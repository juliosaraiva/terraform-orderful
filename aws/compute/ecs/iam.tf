// Allow ECS service to interact with LoadBalancers
data "aws_iam_policy_document" "ecs_service_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_service_auto_scaling" {
  statement {
    actions = [
      "application-autoscaling:*",
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:DisableAlarmActions",
      "cloudwatch:EnableAlarmActions",
      "iam:CreateServiceLinkedRole",
      "sns:CreateTopic",
      "sns:Subscribe",
      "sns:Get*",
      "sns:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ECSInstanceProfile"
  role = aws_iam_role.ecs_service.name
}

resource "aws_iam_role_policy" "autoscaling_policy" {
  name   = "ECSAutoScalingPolicy"
  role   = aws_iam_role.ecs_service.id
  policy = data.aws_iam_policy_document.ecs_service_auto_scaling.json
}


resource "aws_iam_role" "ecs_service" {
  name               = "${var.prefix}-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role_policy.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


data "aws_iam_policy_document" "ecs_task_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task" {
  name               = "ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_policy.json
}

resource "aws_iam_role_policy_attachment" "default_task_role" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "allow_create_log_groups" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "allow_create_log_groups" {
  policy = data.aws_iam_policy_document.allow_create_log_groups.json
  role   = aws_iam_role.ecs_task.id
}
