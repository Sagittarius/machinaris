#
# Performs an hourly log rotate of particularly egregious log files
# Useful for apps that do a poor job of this themselves
#

import os
import subprocess

from api import app

MAX_LOG_SIZE_MB = 20
LOG_ROTATE_CONFIG_DIR = '/etc/logrotate.d/'
LOG_ROTATE_CONFIGS = [
    'farmr',
    'mmx-node',
]

def execute():
    for config in LOG_ROTATE_CONFIGS:
        if os.path.exists(LOG_ROTATE_CONFIG_DIR + config):
            app.logger.info("Rotating config: " + LOG_ROTATE_CONFIG_DIR + config)
            subprocess.call("/usr/sbin/logrotate " + LOG_ROTATE_CONFIG_DIR + config + " >/dev/null 2>&1", shell=True)

    # Extra guards for farmr which can eat GBs of log space sometimes
    if os.path.exists("/root/.chia/farmr"):
        for file in os.listdir("/root/.chia/farmr"):
            if file.startswith("log"):
                size_mbs = os.path.getsize(os.path.join("/root/.chia/farmr", file)) >> 20
                if (size_mbs > MAX_LOG_SIZE_MB): 
                    app.logger.info("Deleting large farmr log at {0}".format(os.path.join("/root/.chia/farmr", file)))
                    os.unlink(os.path.join("/root/.chia/farmr", file))
