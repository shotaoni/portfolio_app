resource "aws_acm_certificate" "tante-acm-certificate" {
  domain_name               = aws_route53_record.tante-route53-record.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "tante-route53-record-certificate" {
  name    = tolist(aws_acm_certificate.tante-acm-certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.tante-acm-certificate.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.tante-acm-certificate.domain_validation_options)[0].resource_record_value]
  zone_id = aws_route53_zone.tante-route53-zone.id
  ttl     = 60
}

resource "aws_acm_certificate_validation" "tante-acm" {
  certificate_arn         = aws_acm_certificate.tante-acm-certificate.arn
  validation_record_fqdns = [aws_route53_record.tante-route53-record-certificate.fqdn]
}