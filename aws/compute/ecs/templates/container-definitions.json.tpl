[
    {
        "name": "${app_name}",
        "image": "${app_image}",
        "essential": true,
        "memoryReservation": 256,
        "environment": [
            {
                "name": "NODE_ENV",
                "value": "prod"
            },
            {
                "name": "MODE",
                "value": "real"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/aws/ecs/devops-challenge",
                "awslogs-region": "us-east-1",
                "awslogs-stream-prefix": "devops-challenge"
            }
        },
        "portMappings": [{
            "containerPort": 4545,
            "hostPort": 0
        }],
        "mountPoints": []
    }
]