pipeline {
    agent any

    environment {
        TOMCAT_VERSION = '9.0.88'
        TOMCAT_USER = 'tomcat'
    }

    stages {
        stage('Install Tomcat') {
            steps {
                sh '''
                    # Add tomcat user if not exists
                    sudo id -u $TOMCAT_USER &>/dev/null || sudo useradd -m -U -d /opt/tomcat -s /bin/false $TOMCAT_USER

                    # Download and install Tomcat
                    cd /tmp
                    wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
                    sudo mkdir -p /opt/tomcat
                    sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1

                    # Set permissions
                    sudo chown -R $TOMCAT_USER: /opt/tomcat
                    sudo chmod +x /opt/tomcat/bin/*.sh

                    # Start Tomcat
                    sudo /opt/tomcat/bin/startup.sh
                '''
            }
        }

        stage('Run Karate Test') {
            steps {
                sh '''
                    echo "Running Karate test"
                    mvn test
                '''
            }
        }
    }
}

