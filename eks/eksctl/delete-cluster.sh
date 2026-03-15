# disabled due to non chmod +x
# !/bin/bash

eksctl delete addon --name aws-ebs-csi-driver --cluster ba-2026-eks --wait

eksctl delete nodegroup --cluster ba-2026-eks --all --wait

eksctl delete iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster ba-2026-eks \
  --wait

eksctl delete cluster ba-2026-eks

# check for remaining resources

aws ec2 describe-volumes --filters Name=status,Values=available --query "Volumes[*].{ID:VolumeId,Size:Size,AZ:AvailabilityZone}" --output table

aws ec2 delete-volume --volume-id <VOLUME_ID>

aws elbv2 describe-load-balancers --query "LoadBalancers[?contains(LoadBalancerName, 'ba-2026-eks')].{Name:LoadBalancerName,ARN:LoadBalancerArn}" --output table

aws logs describe-log-groups --log-group-name-prefix "/aws/eks/ba-2026-eks" --query "logGroups[*].logGroupName" --output table

aws logs delete-log-group --log-group-name /aws/eks/ba-2026-eks/cluster

aws iam list-roles --query "Roles[?contains(RoleName, 'ba-2026-eks')].RoleName" --output table