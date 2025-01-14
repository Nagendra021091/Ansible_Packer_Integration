#!/bin/bash
set -e

# Download artifacts from JFrog Artifactory
echo "Downloading artifacts from Artifactory..."
curl -u "${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD}" \
     -O "${ARTIFACTORY_URL}/path/to/artifact.jar"

# Create application directory
sudo mkdir -p /opt/application
sudo chown -R ec2-user:ec2-user /opt/application

# Move artifacts to application directory
mv artifact.jar /opt/application/

# Set up application service
sudo tee /etc/systemd/system/application.service << EOF
[Unit]
Description=Application Service
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/opt/application
ExecStart=/usr/bin/java -jar /opt/application/artifact.jar
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl enable application
sudo systemctl start application
