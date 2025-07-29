pipeline {
    agent any

    environment {
        TOMCAT_VERSION = '9.0.87'
        TOMCAT_USER = 'tomcat'
        TOMCAT_DIR = '/opt/tomcat'
    }

    stages {
        stage('Install Tomcat') {
            steps {
                sh '''
                    # Create Tomcat user if not exists
                    sudo useradd -m -U -d $TOMCAT_DIR -s /bin/false $TOMCAT_USER || true

                    # Download Tomcat from archive
                    wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

                    # Extract to Tomcat dir
                    sudo mkdir -p $TOMCAT_DIR
                    sudo tar -xf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C $TOMCAT_DIR --strip-components=1

                    # Set permissions
                    sudo chown -R $TOMCAT_USER: $TOMCAT_DIR
                    sudo chmod +x $TOMCAT_DIR/bin/*.sh

                    # Start Tomcat
                    sudo $TOMCAT_DIR/bin/startup.sh
                '''
            }
        }

        stage('Run Karate Test') {
            steps {
                sh '''
                    echo "Running Karate tests"
                    mvn clean test -f blackblet/pom.xml
                '''
            }
        }
    }

    post {
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
        success {
            echo "✅ Build and tests completed successfully!"
        }
        failure {
            echo "❌ Build or tests failed!"
        }
    }
}

