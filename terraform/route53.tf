data "aws_route53_zone" "tante-route53-zone" {
  name = "hellotante.com"
}

resource "aws_route53_record" "tante-route53-record" {
  zone_id = data.aws_route53_zone.tante-route53-zone.zone_id
  name    = data.aws_route53_zone.tante-route53-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.tante-lb.dns_name
    zone_id                = aws_lb.tante-lb.zone_id
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.tante-route53-record.name
}

data "aws_route53_zone" "tante-zone" {
  name    = "hellotante-api.com"
}

resource "aws_route53_record" "tante-zone-record" {
  zone_id = data.aws_route53_zone.tante-zone.zone_id
  name    = data.aws_route53_zone.tante-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.tante-api-lb.dns_name
    zone_id                = aws_lb.tante-api-lb.zone_id
    evaluate_target_health = true
  }
}
