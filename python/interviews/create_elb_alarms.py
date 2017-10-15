
import boto3
import sys
import pprint

# ran out of time and couldnt complete the exercise
# had lots of fun with the challenge thankyou 
# John Bencic


pp = pprint.PrettyPrinter(indent=3)
elb_client = boto3.client('elbv2')
cw_client  = boto3.client('cloudwatch')
sns_client = boto3.client('sns')


def get_loadbalancers():
  return elb_client.describe_load_balancers()['LoadBalancers']


def check_metric_exists(metric_value, metric_name, metric_type='LoadBalancer', namespace='AWS/ApplicationELB'):
  response = cw_client.list_metrics(
    Namespace=namespace,
    MetricName=metric_name,
    Dimensions=[
        {
            'Name': metric_type,
            'Value': metric_value
        },
    ],
  )
  #print (pp.pprint(response['Metrics']))
  if len(response['Metrics']) == 0:
    return False
  else:
    return True

def check_alarm_for_metric_exists(metric_value, metric_name, metric_type='LoadBalancer', namespace='AWS/ApplicationELB'):
  response = cw_client.describe_alarms_for_metric(
    Namespace=namespace,
    MetricName=metric_name,
    Dimensions=[
        {
            'Name': metric_type,
            'Value': metric_value
        },
    ],
  )
  #print (pp.pprint(response['MetricAlarms'][0]['AlarmName']))
  # Testing: delete alarms for metric
  #cw_client.delete_alarms(AlarmNames=[response['MetricAlarms'][0]['AlarmName']])

  if len(response['MetricAlarms']) == 0:
    return False
  else:
    return True


def print_all_alarms():
  print (
    pp.pprint(
      cw_client.describe_alarms()
    )
  )


def print_all_metrics(namespace='AWS/ApplicationELB'):
  print (
    pp.pprint(
      cw_client.list_metrics(
        Namespace=namespace
      )
    )
  )
  

def create_metric_alarm(lb_name, metric_name,threshold, unit, period, statistic, comparison, sns_topic_arn):
  dimensions = [
    {
      'Name': 'LoadBalancer',
      'Value': lb_name
    }

  ]
  kw_args = {
    'AlarmName': "{0}-{1} Alarm".format(lb_name,metric_name) ,
    'ComparisonOperator': comparison,
    'AlarmActions': [sns_topic_arn],
    #OKActions=[sns_topic_arn],
    'EvaluationPeriods': 1,
    'MetricName': metric_name,
    'Namespace': 'AWS/ApplicationELB',
    'Period': period,
    'Statistic': statistic,
    'Threshold': threshold,
    'ActionsEnabled': True,
    'AlarmDescription': "Alarm When {0} exceeds {1}".format(metric_name, threshold),
    'Dimensions': dimensions
  }
  if unit is not None: kw_args['Unit'] = unit

  # Create Alarm
  response = cw_client.put_metric_alarm(**kw_args)

  if check_alarm_for_metric_exists(lb_name, metric_name):
    print ("    Success: Alarm {0}-{1} Successfully created".format(lb_name, metric_name))
    return True
  else:
    print ("    Fail: Alarm {0}-{1} FAILED to create".format(lb_name, metric_name))
    return False




if __name__ == "__main__":
  print ("- Getting all loadbalancers")
  albs =  get_loadbalancers()
  _sns_topic_arn = 'arn:aws:sns:us-east-1:643234842159:John_Bencic'
  # Debugging
  #print_all_metrics()
  #print_all_alarms()

  for alb in albs:
    print ("- Working on lb:" + alb['DNSName'])
    _lb_name= alb['LoadBalancerArn'].split(':loadbalancer/')[1]

    metrics = [
      {
        'metric_name':  'TargetResponseTime',
        'threshold':    1.0,
        'unit':         None, 
        'period':       60,
        'statistic':    'Average',
        'comparison':   'GreaterThanThreshold'
      },
      {
        'metric_name':  'HTTPCode_Target_4XX_Count',
        'threshold':    20,
        'unit':         'Count',
        'period':       60,
        'statistic':    'Sum',
        'comparison':   'GreaterThanThreshold'
      },
      {
        'metric_name':  'HTTPCode_Target_5XX_Count',
        'threshold':    20,
        'unit':         'Count',
        'period':       60,
        'statistic':    'Sum',
        'comparison':   'GreaterThanThreshold'
      }
    ]


    for metric in metrics:

      if check_alarm_for_metric_exists(_lb_name, metric['metric_name']):
        print ("  Alarm for metric {0} exists on {1}".format(metric['metric_name'], _lb_name))
      else:
        print ("  Alarm for metric {0} does NOT exists on {1}, Creating...".format(metric['metric_name'], _lb_name))
        create_metric_alarm(
          _lb_name,
          metric['metric_name'],
          metric['threshold'],
          metric['unit'],
          metric['period'],
          metric['statistic'],
          metric['comparison'],
          _sns_topic_arn
        )
