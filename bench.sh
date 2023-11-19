#!/usr/bin/env bash
set -e

# TODO:
# - Take host as argument
# - Can we control the endpoint of triton servers?
# - Otherwise need to pass that into the locust file too I guess
# - Do we have to launch it from the gui? --headless I think

locust -f locust.py --host http://127.0.0.1:8000
