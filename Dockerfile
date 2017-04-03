FROM continuumio/anaconda3:4.3.1

# libgl1-mesa-glx fixes matplotlib qt5 support
RUN apt-get --yes install libgomp1 libgl1-mesa-glx && apt-get clean

RUN conda update conda; conda update --all
RUN conda config --add channels omnia
RUN conda install --yes -c omnia/label/pre pyemma
RUN conda install --yes -c liulab cufflinks
RUN conda install --yes -c qttesting libxcb
RUN conda install --yes seaborn matplotlib plotly
RUN conda install --yes -c fabianrost pandas-datareader
RUN pip install --upgrade pip
RUN pip install datapackage

# to reduce startup time, build font cache for matplotlib
RUN python -c "import numpy as np, pickle, pyemma; import matplotlib.pyplot"

COPY ./stream-stdin.py /scripts/stream-stdin.py
COPY ./pyemma_logging.yml /root/.pyemma/logging.yml
