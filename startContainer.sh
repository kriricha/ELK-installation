pipeline {
    agent any
    
    stages {
        stage('Build and Run Elasticsearch') {
            steps {
                script {
                    // Start Elasticsearch container
                    docker.image('docker.elastic.co/elasticsearch/elasticsearch:7.16.3').run(
                        '-p 9200:9200 -p 9300:9300 ' +
                        '-e "discovery.type=single-node" ' +
                        '--name elasticsearch'
                    )
                }
            }
        }
        
        stage('Build and Run Logstash') {
            steps {
                script {
                    // Start Logstash container
                    // Assuming Logstash configuration files are in /path/to/logstash/config on Jenkins host
                    docker.image('docker.elastic.co/logstash/logstash:7.16.3').run(
                        '--link elasticsearch:elasticsearch ' +
                        '-v /path/to/logstash/config:/usr/share/logstash/config ' +
                        '--name logstash'
                    )
                }
            }
        }
        
        stage('Build and Run Kibana') {
            steps {
                script {
                    // Start Kibana container
                    docker.image('docker.elastic.co/kibana/kibana:7.16.3').run(
                        '--link elasticsearch:elasticsearch ' +
                        '-p 5601:5601 ' +
                        '--name kibana'
                    )
                }
            }
        }
    }
}
