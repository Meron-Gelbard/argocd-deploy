#!/bin/bash

VERSION_TAG=$1

cat << EOF > deployment.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: weather-app

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: weather-app
  namespace: weather-app
  labels:
    app: weather-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: weather-app
  template:
    metadata:
      labels:
        app: weather-app
    spec:
      containers:
        - name: weather-app
          image: merongelbard/weather-app-gunicorn:$VERSION_TAG
          ports:
            - containerPort: 8080

EOF