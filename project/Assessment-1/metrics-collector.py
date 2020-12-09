# Set the python path
import inspect
import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))))

import shutil
import threading
from http.server import HTTPServer
import socket
import time

from prometheus.collectors import Gauge
from prometheus.registry import Registry
from prometheus.exporter import PrometheusMetricHandler
import psutil
import boto3
from botocore.client import Config
PORT_NUMBER = 4444


def gather_data(registry):
    """Gathers the metrics"""

    # Get the host name of the machine
    host = socket.gethostname()

    # Create our collectors
    ram_metric = Gauge("memory_usage_bytes", "Memory usage in bytes.",
                       {'host': host})
    cpu_metric = Gauge("cpu_usage_percent", "CPU usage percent.",
                       {'host': host})
    disk_metric = Gauge("disk_usage_bytes", "Disk usage in bytes.",
                       {'host': host})
    # register the metric collectors
    registry.register(ram_metric)
    registry.register(cpu_metric)
    registry.register(disk_metric)
    # Start gathering metrics every second
    while True:
        time.sleep(1)
     #   disk = psutil.disk_usage('/') 
        # Add ram metrics
        ram = psutil.virtual_memory()
        swap = psutil.swap_memory()

        ram_metric.set({'type': "virtual", }, ram.used)
        ram_metric.set({'type': "virtual", 'status': "cached"}, ram.cached)
        ram_metric.set({'type': "swap"}, swap.used)

        # Add cpu metrics
        for c, p in enumerate(psutil.cpu_percent(interval=1, percpu=True)):
            cpu_metric.set({'core': c}, p)

        disk_total, disk_used, disk_free = shutil.disk_usage("/")
        disk_metric.set({'type': "total", }, disk_total)
        disk_metric.set({'type': "total", }, disk_used)
        disk_metric.set({'type': "total", }, disk_free)    

def putLogOnS3():
    AWS_KEY_ID = 'XXXXXXXXXXXx'
    AWS_SECRET_KEY = 'XXXXXXXXXXXXXXXXXXXXXXXX'
    BUCKET_NAME = 'Project.Prod.ServiceLogs'
    servicename = "nginx"
    s3 = boto3.resource('s3')
    fileNameWithFolder = "/var/log/"+servicename+"/"+"access.log"
    dbUsers = open(fileNameWithFolder, 'rb')
    s3 = boto3.resource('s3',aws_access_key_id=AWS_KEY_ID,aws_secret_access_key=AWS_SECRET_KEY,config=Config(signature_version='s3v4'))
    s3.Bucket(BUCKET_NAME).put_object(Key=fileNameWithFolder, Body=dbUsers)

if __name__ == "__main__":

    # Create the registry
    registry = Registry()
    
    # S3 upload service logs
    putLogOnS3()

    # Create the thread that gathers the data while we serve it
    thread = threading.Thread(target=gather_data, args=(registry, ))
    thread.start()

    # Set a server to export (expose to prometheus) the data (in a thread)
    try:
        # We make this to set the registry in the handler
        def handler(*args, **kwargs):
            PrometheusMetricHandler(registry, *args, **kwargs)

        server = HTTPServer(('', PORT_NUMBER), handler)
        server.serve_forever()

    except KeyboardInterrupt:
        server.socket.close()
        thread.join()
