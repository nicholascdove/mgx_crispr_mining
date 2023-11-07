FROM continuumio/anaconda3
ARG pipeline

#RUN conda create -n cctyper -c conda-forge -c bioconda -c russel88 cctyper

RUN conda install -c russel88 cctyper

RUN pip install --ignore-installed awscli==1.19.27 \
  && pip install --ignore-installed pyarrow==6.0.1 \
  && pip install --ignore-installed awscli==1.19.27 \
  && pip install --ignore-installed awswrangler==2.14.0 \
  && pip install --ignore-installed pandas==1.3.5 

COPY $pipeline/job.sh /usr/local/bin/
COPY $pipeline/parse_cctyper_out.py /usr/local/bin/
#COPY common_utils /common_utils

#RUN pip install /common_utils

ENTRYPOINT ["job.sh"]
