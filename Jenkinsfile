pipeline{
    agent any
    parameters {
  string defaultValue: 'terraform', description: 'workspace/environment to use for deployment', name: 'environment'
  booleanParam defaultValue: true, description: 'automatically run apply after generating plan?', name: 'autoapprove'
}
environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID') 
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
}
    stages{
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/soumenduparia9/aws-terraform.git"
                        }
                    }
                }
            post{
                always{
                    echo "checkout stage completed"
                }
                success{
                    echo "git checkout successed"
                }
                failure{
                    echo "git checkout failed"
                }
            }
        }
        stage("Plan"){
            steps{
                sh 'pwd && cd terraform/ && terraform init -input=false'
                sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'
                sh 'pwd && cd terraform/ && terraform plan -input=false -out tfplan'
                sh 'pwd && cd terraform/ && terraform show -no-color tfplan > tfplan.txt '
            }
            post{
                always{
                    echo "plan stage completed"
                }
                success{
                    echo "plan successed"
                }
                failure{
                    echo "plan failed"
                }
            }
        }
        stage("Approval"){
            when{
                not{
                    equals expected: true,actual: params.autoapprove
                }
            }
            steps{
                script{
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: 'do you want to apply the plan ?', ok: 'ok you should'
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
            post{
                always{
                    echo "approval stage completed"
                }
                success{
                    echo "approval successed"
                }
                failure{
                    echo "approval failed"
                }
            }
        }
        stage("Apply"){
            steps{
                sh 'pwd && cd terraform/ && terraform apply -input=false tfplan'
            }
            post{
                always{
                    echo "apply stage completed"
                }
                success{
                    echo "apply successed"
                }
                failure{
                    echo "apply failed"
                }
            }
        }
    }
    post{
        always{
            echo "terraform pipeline completed"
        }
        success{
            echo "pipeline job successed"
            slackSend channel: 'cloud-jenkins', message: 'job successed'
        }
        failure{
            echo "pipeline job failed"
            slackSend channel: 'cloud-jenkins', message: 'job failed'
        }
    }
}
