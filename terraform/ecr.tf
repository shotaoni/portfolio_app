resource "aws_ecr_repository" "tante-front" {
  name = "tante-front"
}

resource "aws_ecr_lifecycle_policy" "tante-front-policy" {
  repository = aws_ecr_repository.tante-front.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}

resource "aws_ecr_repository" "tante-api" {
  name = "tante-api"
}

resource "aws_ecr_lifecycle_policy" "tante-api-policy" {
  repository = aws_ecr_repository.tante-api.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}