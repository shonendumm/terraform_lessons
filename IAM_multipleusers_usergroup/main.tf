provider "aws" {
  region = "ap-southeast-1"
}


variable "usernames" {
  type    = list(string)
  default = ["user1", "user2", "user3"]
}


# Creates multiple users from the list of usernames
resource "aws_iam_user" "users" {
  for_each = toset(var.usernames)
  name     = each.key
}

# Assign user group membership multiple times, based on the usernames vars
resource "aws_iam_user_group_membership" "example1" {
    for_each = toset(var.usernames)
    user = aws_iam_user.users[each.key].name

    groups = [
        aws_iam_group.developers.name,
    ]
}



# Manage group membership from group overview
# resource "aws_iam_group_membership" "example1" {
#   name = aws_iam_group.developers.name
#   users = [for user in var.usernames: aws_iam_user.users[user].name ]
#   group = aws_iam_group.developers.name
# }


# Creates a IAM user group
resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}


# Provides an IAM policy attached to a group.
resource "aws_iam_group_policy" "developers_policy" {
  name  = "developers_policy"
  group = aws_iam_group.developers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeFastLaunchImages",
          "ec2:DescribeInstances",
          "ec2:GetVerifiedAccessGroupPolicy",
          "ec2:DescribeCoipPools",
          "ec2:DescribeVerifiedAccessEndpoints",
          "ec2:DescribeSnapshots",
          "ec2:DescribeLocalGatewayVirtualInterfaces",
          "ec2:DescribeNetworkInsightsPaths",
          "ec2:DescribeHostReservationOfferings",
          "ec2:DescribeTrafficMirrorSessions",
          "ec2:DescribeExportImageTasks",
          "ec2:DescribeTrafficMirrorFilters",
          "ec2:DescribeVolumeStatus",
          "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
          "ec2:DescribeScheduledInstanceAvailability",
          "ec2:DescribeVolumes",
          "ec2:DescribeFpgaImageAttribute",
          "ec2:DescribeExportTasks",
          "ec2:DescribeTransitGatewayMulticastDomains",
          "ec2:DescribeManagedPrefixLists",
          "ec2:DescribeKeyPairs",
          "ec2:GetVerifiedAccessEndpointPolicy",
          "ec2:DescribeReservedInstancesListings",
          "ec2:DescribeCapacityReservations",
          "ec2:DescribeClientVpnRoutes",
          "ec2:DescribeSpotFleetRequestHistory",
          "ec2:DescribeVpcClassicLinkDnsSupport",
          "ec2:DescribeSnapshotAttribute",
          "ec2:DescribeIpamResourceDiscoveryAssociations",
          "ec2:DescribeIdFormat",
          "ec2:DescribeFastSnapshotRestores",
          "ec2:DescribeInstanceEventWindows",
          "ec2:DescribeVolumeAttribute",
          "ec2:GetVpnTunnelReplacementStatus",
          "ec2:DescribeImportSnapshotTasks",
          "ec2:DescribeLocalGatewayVirtualInterfaceGroups",
          "ec2:DescribeVpcEndpointServicePermissions",
          "ec2:DescribeTransitGatewayAttachments",
          "ec2:DescribeAddressTransfers",
          "ec2:DescribeScheduledInstances",
          "ec2:SearchLocalGatewayRoutes",
          "ec2:DescribeTrunkInterfaceAssociations",
          "ec2:DescribeImageAttribute",
          "ec2:DescribeInstanceConnectEndpoints",
          "ec2:DescribeIpv6Pools",
          "ec2:DescribeFleets",
          "ec2:DescribeReservedInstancesModifications",
          "ec2:DescribeAwsNetworkPerformanceMetricSubscriptions",
          "ec2:DescribeSubnets",
          "ec2:DescribeMovingAddresses",
          "ec2:DescribeCapacityReservationFleets",
          "ec2:DescribeFleetHistory",
          "ec2:DescribePrincipalIdFormat",
          "ec2:DescribeVerifiedAccessGroups",
          "ec2:DescribeFlowLogs",
          "ec2:DescribeRegions",
          "ec2:DescribeTransitGateways",
          "ec2:DescribeVpcEndpointServices",
          "ec2:DescribeSpotInstanceRequests",
          "ec2:DescribeAddressesAttribute",
          "ec2:DescribeVpcAttribute",
          "ec2:GetTransitGatewayPolicyTableEntries",
          "ec2:DescribeVerifiedAccessTrustProviders",
          "ec2:DescribeVerifiedAccessInstanceLoggingConfigurations",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeTrafficMirrorTargets",
          "ec2:DescribeTransitGatewayRouteTables",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeNetworkInterfaceAttribute",
          "ec2:DescribeLocalGatewayRouteTables",
          "ec2:DescribeVpcEndpointConnections",
          "ec2:SearchTransitGatewayMulticastGroups",
          "ec2:DescribeInstanceStatus",
          "ec2:GetIpamPoolAllocations",
          "ec2:DescribeHostReservations",
          "ec2:DescribeBundleTasks",
          "ec2:DescribeIdentityIdFormat",
          "ec2:DescribeClassicLinkInstances",
          "ec2:DescribeTransitGatewayConnects",
          "ec2:DescribeIpamPools",
          "ec2:DescribeVpcEndpointConnectionNotifications",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeStoreImageTasks",
          "ec2:DescribeFpgaImages",
          "ec2:DescribeVpcs",
          "ec2:DescribeIpams",
          "ec2:DescribeStaleSecurityGroups",
          "ec2:DescribeAggregateIdFormat",
          "ec2:DescribeVolumesModifications",
          "ec2:DescribeTransitGatewayRouteTableAnnouncements",
          "ec2:DescribeClientVpnConnections",
          "ec2:DescribeTransitGatewayConnectPeers",
          "ec2:DescribeByoipCidrs",
          "ec2:DescribeNetworkInsightsAnalyses",
          "ec2:DescribePlacementGroups",
          "ec2:DescribeInternetGateways",
          "ec2:SearchTransitGatewayRoutes",
          "ec2:DescribeSpotDatafeedSubscription",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeNetworkInterfacePermissions",
          "ec2:DescribeReservedInstances",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeRouteTables",
          "ec2:DescribeClientVpnEndpoints",
          "ec2:DescribeEgressOnlyInternetGateways",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeVpnConnections",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeReservedInstancesOfferings",
          "ec2:GetTransitGatewayAttachmentPropagations",
          "ec2:DescribeFleetInstances",
          "ec2:GetGroupsForCapacityReservation",
          "ec2:DescribeClientVpnTargetNetworks",
          "ec2:DescribeSnapshotTierStatus",
          "ec2:DescribeVpcEndpointServiceConfigurations",
          "ec2:DescribeVerifiedAccessInstances",
          "ec2:DescribePrefixLists",
          "ec2:DescribeInstanceCreditSpecifications",
          "ec2:DescribeVpcClassicLink",
          "ec2:DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociations",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeIpamResourceDiscoveries",
          "ec2:GetTransitGatewayRouteTablePropagations",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeElasticGpus",
          "ec2:DescribeVpnGateways",
          "ec2:ListSnapshotsInRecycleBin",
          "ec2:DescribeTransitGatewayPolicyTables",
          "ec2:DescribeTransitGatewayPeeringAttachments",
          "ec2:DescribeAddresses",
          "ec2:DescribeIpamScopes",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeNetworkInterfaces"
        ],
        "Resource" : "*"
      }
    ]
  })
}

