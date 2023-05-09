# step 1: get python 3.7.3
FROM python:3.7.3-stretch

# set working directory
WORKDIR /app

# copy necessary files to the working directory
COPY . /app/

# install packages
RUN pip install --upgrade pip==23.1.2 && \
    pip install -r requirements.txt

# expose the port 80
EXPOSE 80

# run the command
CMD ["python", "app.py"]
