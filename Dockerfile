FROM jupyter/datascience-notebook:python-3.7.6
WORKDIR work
RUN pip install tensorflow keras pydot graphviz
RUN git config --global user.email "kirkins@gmail.com"
RUN git config --global user.name "Philip Kirkbride"
COPY . .
USER root
RUN apt-get update && apt-get install -y graphviz git
RUN chmod -R 777 *
