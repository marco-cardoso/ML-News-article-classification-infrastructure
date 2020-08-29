FROM python:3.7
MAINTAINER Marco Cardoso

# Create the user to run the app
RUN adduser --disabled-password --gecos '' app-user

# Environment variables
ENV MONGO_HOST localhost
ENV MONGO_PORT 21017

# Install news_classifier dependencies
RUN mkdir -p /opt/services/news_classifier

COPY ./packages /opt/services/news_classifier
WORKDIR /opt/services/news_classifier/news_classifier
RUN python setup.py install

# Install the webapp dependencies
WORKDIR /opt/services/news_classifier/webapp
RUN pip install -r requirements.txt

# Change run.sh permissions
RUN chmod +x /opt/services/news_classifier/webapp/run.sh
RUN chown -R app-user:app-user ./

# Expose port and running cmd as app-user
USER app-user
EXPOSE 5000
CMD ["/bin/sh", "run.sh"]