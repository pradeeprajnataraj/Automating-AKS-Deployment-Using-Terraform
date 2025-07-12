pipeline {
  agent any

  environment {
    AZURE_CREDENTIALS = credentials('azurespn')
    ACR_NAME = 'youracrname.azurecr.io'
    IMAGE_NAME = 'spring-petclinic'
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/pradeeprajnataraj/Automating-AKS-Deployment-Using-Terraform.git'
      }
    }

    stage('Build with Maven') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('SonarQube Analysis') {
      environment {
        SONAR_SCANNER_OPTS = "-Xmx512m"
      }
      steps {
        withSonarQubeEnv('SonarQube') {
          sh 'mvn sonar:sonar -Dsonar.projectKey=enhanced-petclinic-prod'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $ACR_NAME/$IMAGE_NAME:latest .'
      }
    }

    stage('Azure Login & ACR Push') {
      steps {
        sh '''
          az login --service-principal -u $AZURE_CREDENTIALS_USR -p $AZURE_CREDENTIALS_PSW --tenant $AZURE_CREDENTIALS_TEN
          az acr login --name ${ACR_NAME%.azurecr.io}
          docker push $ACR_NAME/$IMAGE_NAME:latest
        '''
      }
    }

    stage('Deploy to AKS') {
      steps {
        sh '''
          az aks get-credentials --resource-group aksrginfra --name akscluster1100 --overwrite-existing
          kubectl apply -f k8s-deployment.yaml
        '''
      }
    }
  }
}

