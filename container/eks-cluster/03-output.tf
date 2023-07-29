# output "vpc_id" {
#     value = aws_eks_cluster.default
# }

output "eks_cluster_name" {
    description = "The name of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.name}
}

output "eks_cluster_endpoint" {
    description = "The endpoint of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.endpoint}
}

output "eks_cluster_certificate_authority" {
    #### kubeconfig-certificate-authority-data
    description = "The certificate_authority of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.certificate_authority[0].data}
}

output "eks_cluster_allocation_role" {
    description = "The role_arn of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.role_arn}
}

output "eks_cluster_version" {
    description = "The version of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.version}
}

output "eks_cluster_Network_Config" {
    description = "The network config of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.vpc_config}
}

output "eks_cluster_kubernetes_network_config" {
    description = "The kubernetes network config of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.kubernetes_network_config}
}

output "eks_cluster_encryption" {
    description = "The encryption of the EKS Cluster"
    value       = { for key, clsuter in aws_eks_cluster.default : key => clsuter.encryption_config}
}