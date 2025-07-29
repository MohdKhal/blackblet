pipeline {
    agent any

    stages {
        stage('Install Tomcat') {
            steps {
                sh '''
                TOMCAT_VERSION=9.0.87
                TOMCAT_USER=tomcat

                sudo useradd -m -U -d /opt/$TOMCAT_USER -s /bin/false $TOMCAT_USER || true

                wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

                sudo mkdir -p /opt/$TOMCAT_USER
                sudo tar -xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/$TOMCAT_USER --strip-components=1
                sudo sh -c 'chmod +x /opt/'$TOMCAT_USER'/bin/*.sh'
                sudo sh -c '/opt/'$TOMCAT_USER'/bin/startup.sh'

                sudo ufw allow 8080 || true
                sleep 10
                '''
            }
        }

        stage('Run Karate Test') {
            steps {
                sh 'mvn clean test'
            }
        }
    }
}

