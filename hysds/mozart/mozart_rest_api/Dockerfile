FROM ghcr.io/unity-sds/unity-cs-sps-demo/hysds-core:main

ARG HOME /root
WORKDIR $HOME

ENV WORKERS 4
ENV THREADS 1

RUN pip3 install 'Flask<2.0.0' && \
  pip3 install 'Werkzeug<2.0.0' && \
  pip3 install 'flask-cors'

RUN git clone https://github.com/hysds/mozart.git && \
  cd mozart/ && git fetch origin && git checkout -b build 44ed1b70114d65d8fe10c56ce4ef22460764f882 &&\
  python3 setup.py install

WORKDIR /root/mozart

CMD ["sh", "-c", "gunicorn \
  --workers $WORKERS --threads $THREADS \
  -b 0.0.0.0:8888 -k gevent \
  --timeout=3600 --graceful-timeout=3600 --log-level=debug --limit-request-line=0 \
  mozart:app"]
