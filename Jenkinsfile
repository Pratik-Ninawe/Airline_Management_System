pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat """
                docker run -v "%CD%":/workspace maven:3.9.9-eclipse-temurin-21 /bin/sh -c "cd /workspace && mvn clean package"
                """
            }
        }

        stage('Test') {
            steps {
                bat """
                docker run -v "%CD%":/workspace maven:3.9.9-eclipse-temurin-21 /bin/sh -c "cd /workspace && mvn test"
                """
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
                    bat """
                        icacls "%SSH_KEY%" /inheritance:r
                        icacls "%SSH_KEY%" /grant:r "%USERNAME%:F"

                        echo Starting deployment at %DATE% && time /t

                        echo Copying JAR file...
                        C:\\Windows\\System32\\OpenSSH\\scp.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" target\\airline-0.0.1-SNAPSHOT.jar %SSH_USER%@35.170.192.250:/home/%SSH_USER%/

                        echo Installing Java 21...
                        C:\\Windows\\System32\\OpenSSH\\ssh.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "sudo amazon-linux-extras enable corretto8 && sudo yum install -y java-21-amazon-corretto"

                        echo Killing existing processes...
                        C:\\Windows\\System32\\OpenSSH\\ssh.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "sudo pkill -f 'java -jar' || true; sudo lsof -ti :8081 | xargs -r sudo kill -9 || true"

                        echo Waiting for cleanup...
                        C:\\Windows\\System32\\OpenSSH\\ssh.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "sleep 10"

                        echo Starting application...
                        C:\\Windows\\System32\\OpenSSH\\ssh.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "nohup java -jar /home/%SSH_USER%/airline-0.0.1-SNAPSHOT.jar --server.port=8081 --server.address=0.0.0.0 >> /home/%SSH_USER%/airline.log 2>&1 &"

                        echo Verifying application health...
                        C:\\Windows\\System32\\OpenSSH\\ssh.exe -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "for i in 1 2 3 4 5; do curl -sSf http://localhost:8081/actuator/health | grep -q '\\"status\\":\\"UP\\"' && break || sleep 10; done || { echo 'Startup failed'; tail -n 100 /home/%SSH_USER%/airline.log; exit 1; }"

                        echo Deployment finished at %DATE% && time /t
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    retry(5) {
                        timeout(time: 3, unit: 'MINUTES') {
                            bat """
                            echo Waiting for application initialization...
                            ping 127.0.0.1 -n 90 > nul

                            echo Testing connectivity...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 http://35.170.192.250:8081/actuator/health | findstr "UP"

                            echo Creating test data for tickets...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 -X POST -H "Content-Type: application/json" -d "{\\"scheduleId\\":1,\\"passengerName\\":\\"John Doe\\",\\"passengerEmail\\":\\"john.doe@example.com\\",\\"seatNumber\\":\\"12A\\"}" http://35.170.192.250:8081/api/tickets

                            echo Validating GET /api/flights?sort=asc...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 "http://35.170.192.250:8081/api/flights?sort=asc"

                            echo Validating GET /api/flights/{id}...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 http://35.170.192.250:8081/api/flights/1

                            echo Validating GET /api/tickets/{id}...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 http://35.170.192.250:8081/api/tickets/1

                            echo Validating DELETE /api/tickets/{id}...
                            curl -v --retry 5 --retry-delay 10 --max-time 30 -X DELETE http://35.170.192.250:8081/api/tickets/1
                            """
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts 'target/*.jar'
            junit 'target/surefire-reports/*.xml'
        }
        failure {
            withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
                bat """
                ssh -o ConnectTimeout=30 -o StrictHostKeyChecking=no -i "%SSH_KEY%" %SSH_USER%@35.170.192.250 "tail -n 100 /home/%SSH_USER%/airline.log" > deployment.log
                """
            }
            archiveArtifacts artifacts: 'deployment.log', allowEmptyArchive: true
        }
    }
}
