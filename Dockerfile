FROM fedora:33

RUN dnf install python -y 

RUN pip install numpy matplotlib

#RUN pip install jupyter notebook

#RUN pip install markdown-kernel
RUN pip install --no-cache-dir notebook
