# Helm chart `aws-load-balancer-controller` 3.6.0 from https://aws.github.io/eks-charts, imported by Archie.
# The chart stays upstream; this pins its version. Upgrading is a new version.
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12"
    }
  }
}

resource "helm_release" "this" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "3.6.0"

  # Only what was set; Helm merges it over the chart's own defaults. An
  # untouched map is `{}`, dropped too: nothing to merge.
  values = [yamlencode({ for k, v in {
      "replicaCount" = var.replicaCount,
      "revisionHistoryLimit" = var.revisionHistoryLimit,
      "image" = var.image,
      "runtimeClassName" = var.runtimeClassName,
      "imagePullSecrets" = var.imagePullSecrets,
      "nameOverride" = var.nameOverride,
      "fullnameOverride" = var.fullnameOverride,
      "autoscaling" = var.autoscaling,
      "serviceAccount" = var.serviceAccount,
      "rbac" = var.rbac,
      "podSecurityContext" = var.podSecurityContext,
      "securityContext" = var.securityContext,
      "terminationGracePeriodSeconds" = var.terminationGracePeriodSeconds,
      "resources" = var.resources,
      "priorityClassName" = var.priorityClassName,
      "nodeSelector" = var.nodeSelector,
      "tolerations" = var.tolerations,
      "affinity" = var.affinity,
      "configureDefaultAffinity" = var.configureDefaultAffinity,
      "topologySpreadConstraints" = var.topologySpreadConstraints,
      "updateStrategy" = var.updateStrategy,
      "serviceAnnotations" = var.serviceAnnotations,
      "deploymentAnnotations" = var.deploymentAnnotations,
      "podAnnotations" = var.podAnnotations,
      "podLabels" = var.podLabels,
      "additionalLabels" = var.additionalLabels,
      "enableCertManager" = var.enableCertManager,
      "certManager" = var.certManager,
      "clusterName" = var.clusterName,
      "cluster" = var.cluster,
      "ingressClass" = var.ingressClass,
      "ingressClassParams" = var.ingressClassParams,
      "createIngressClassResource" = var.createIngressClassResource,
      "region" = var.region,
      "vpcId" = var.vpcId,
      "vpcTags" = var.vpcTags,
      "awsApiEndpoints" = var.awsApiEndpoints,
      "awsApiThrottle" = var.awsApiThrottle,
      "awsMaxRetries" = var.awsMaxRetries,
      "defaultTargetType" = var.defaultTargetType,
      "defaultLoadBalancerScheme" = var.defaultLoadBalancerScheme,
      "enablePodReadinessGateInject" = var.enablePodReadinessGateInject,
      "enableShield" = var.enableShield,
      "enableWaf" = var.enableWaf,
      "enableWafv2" = var.enableWafv2,
      "ingressMaxConcurrentReconciles" = var.ingressMaxConcurrentReconciles,
      "logLevel" = var.logLevel,
      "metricsBindAddr" = var.metricsBindAddr,
      "webhookConfig" = var.webhookConfig,
      "webhookBindPort" = var.webhookBindPort,
      "webhookTLS" = var.webhookTLS,
      "keepTLSSecret" = var.keepTLSSecret,
      "webhookNamespaceSelectors" = var.webhookNamespaceSelectors,
      "serviceMaxConcurrentReconciles" = var.serviceMaxConcurrentReconciles,
      "targetgroupbindingMaxConcurrentReconciles" = var.targetgroupbindingMaxConcurrentReconciles,
      "targetgroupbindingMaxExponentialBackoffDelay" = var.targetgroupbindingMaxExponentialBackoffDelay,
      "targetgroupbindingRequeueDuration" = var.targetgroupbindingRequeueDuration,
      "albGatewayMaxConcurrentReconciles" = var.albGatewayMaxConcurrentReconciles,
      "nlbGatewayMaxConcurrentReconciles" = var.nlbGatewayMaxConcurrentReconciles,
      "globalAcceleratorMaxConcurrentReconciles" = var.globalAcceleratorMaxConcurrentReconciles,
      "globalAcceleratorMaxExponentialBackoffDelay" = var.globalAcceleratorMaxExponentialBackoffDelay,
      "lbStabilizationMonitorInterval" = var.lbStabilizationMonitorInterval,
      "syncPeriod" = var.syncPeriod,
      "watchNamespace" = var.watchNamespace,
      "disableIngressClassAnnotation" = var.disableIngressClassAnnotation,
      "disableIngressGroupNameAnnotation" = var.disableIngressGroupNameAnnotation,
      "tolerateNonExistentBackendService" = var.tolerateNonExistentBackendService,
      "tolerateNonExistentBackendAction" = var.tolerateNonExistentBackendAction,
      "defaultSSLPolicy" = var.defaultSSLPolicy,
      "livenessProbe" = var.livenessProbe,
      "readinessProbe" = var.readinessProbe,
      "env" = var.env,
      "hostNetwork" = var.hostNetwork,
      "dnsPolicy" = var.dnsPolicy,
      "extraVolumeMounts" = var.extraVolumeMounts,
      "extraVolumes" = var.extraVolumes,
      "defaultTags" = var.defaultTags,
      "podDisruptionBudget" = var.podDisruptionBudget,
      "externalManagedTags" = var.externalManagedTags,
      "enableEndpointSlices" = var.enableEndpointSlices,
      "enableBackendSecurityGroup" = var.enableBackendSecurityGroup,
      "enableManageBackendSecurityGroupRules" = var.enableManageBackendSecurityGroupRules,
      "backendSecurityGroup" = var.backendSecurityGroup,
      "disableRestrictedSecurityGroupRules" = var.disableRestrictedSecurityGroupRules,
      "maxTargetsPerTargetGroup" = var.maxTargetsPerTargetGroup,
      "controllerConfig" = var.controllerConfig,
      "certManagement" = var.certManagement,
      "certDiscovery" = var.certDiscovery,
      "objectSelector" = var.objectSelector,
      "serviceMonitor" = var.serviceMonitor,
      "clusterSecretsPermissions" = var.clusterSecretsPermissions,
      "ingressClassConfig" = var.ingressClassConfig,
      "enableServiceMutatorWebhook" = var.enableServiceMutatorWebhook,
      "serviceMutatorWebhookConfig" = var.serviceMutatorWebhookConfig,
      "podMutatorWebhookConfig" = var.podMutatorWebhookConfig,
      "serviceTargetENISGTags" = var.serviceTargetENISGTags,
      "loadBalancerClass" = var.loadBalancerClass
  } : k => v if v != null && v != {} })]
}


variable "release_name" {
  description = "Name of the Helm release."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "namespace" {
  description = "Namespace the release is installed into."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "create_namespace" {
  description = "Create the namespace when it does not exist."
  type        = bool
  default     = true
}

variable "replicaCount" {
  description = "Chart value `replicaCount`. Chart default: 2"
  type        = any
  default     = null
}

variable "revisionHistoryLimit" {
  description = "Chart value `revisionHistoryLimit`. Chart default: 10"
  type        = any
  default     = null
}

variable "image" {
  description = "Chart value `image`. Chart default: {'repository': 'public.ecr.aws/eks/aws-load-balancer-controller', 'tag': 'v3.6.0', 'pullPolicy': 'IfNotPresent'}"
  type        = any
  default     = {}
}

variable "runtimeClassName" {
  description = "Chart value `runtimeClassName`. Chart default: ''"
  type        = any
  default     = null
}

variable "imagePullSecrets" {
  description = "Chart value `imagePullSecrets`. Chart default: []"
  type        = any
  default     = null
}

variable "nameOverride" {
  description = "Chart value `nameOverride`. Chart default: ''"
  type        = any
  default     = null
}

variable "fullnameOverride" {
  description = "Chart value `fullnameOverride`. Chart default: ''"
  type        = any
  default     = null
}

variable "autoscaling" {
  description = "Chart value `autoscaling`. Chart default: {'enabled': false, 'minReplicas': 1, 'maxReplicas': 5, 'targetCPUUtilizationPercentage': 80}"
  type        = any
  default     = {}
}

variable "serviceAccount" {
  description = "Chart value `serviceAccount`. Chart default: {'create': true, 'annotations': {}, 'name': null, 'automountServiceAccountToken': true, 'imagePullSecrets': null}"
  type        = any
  default     = {}
}

variable "rbac" {
  description = "Chart value `rbac`. Chart default: {'create': true}"
  type        = any
  default     = {}
}

variable "podSecurityContext" {
  description = "Chart value `podSecurityContext`. Chart default: {'fsGroup': 65534}"
  type        = any
  default     = {}
}

variable "securityContext" {
  description = "Chart value `securityContext`. Chart default: {'readOnlyRootFilesystem': true, 'runAsNonRoot': true, 'allowPrivilegeEscalation': false}"
  type        = any
  default     = {}
}

variable "terminationGracePeriodSeconds" {
  description = "Chart value `terminationGracePeriodSeconds`. Chart default: 10"
  type        = any
  default     = null
}

variable "resources" {
  description = "Chart value `resources`. Chart default: {}"
  type        = any
  default     = {}
}

variable "priorityClassName" {
  description = "Chart value `priorityClassName`. Chart default: 'system-cluster-critical'"
  type        = any
  default     = null
}

variable "nodeSelector" {
  description = "Chart value `nodeSelector`. Chart default: {}"
  type        = any
  default     = {}
}

variable "tolerations" {
  description = "Chart value `tolerations`. Chart default: []"
  type        = any
  default     = null
}

variable "affinity" {
  description = "Chart value `affinity`. Chart default: {}"
  type        = any
  default     = {}
}

variable "configureDefaultAffinity" {
  description = "Chart value `configureDefaultAffinity`. Chart default: true"
  type        = any
  default     = null
}

variable "topologySpreadConstraints" {
  description = "Chart value `topologySpreadConstraints`. Chart default: []"
  type        = any
  default     = null
}

variable "updateStrategy" {
  description = "Chart value `updateStrategy`. Chart default: {}"
  type        = any
  default     = {}
}

variable "serviceAnnotations" {
  description = "Chart value `serviceAnnotations`. Chart default: {}"
  type        = any
  default     = {}
}

variable "deploymentAnnotations" {
  description = "Chart value `deploymentAnnotations`. Chart default: {}"
  type        = any
  default     = {}
}

variable "podAnnotations" {
  description = "Chart value `podAnnotations`. Chart default: {}"
  type        = any
  default     = {}
}

variable "podLabels" {
  description = "Chart value `podLabels`. Chart default: {}"
  type        = any
  default     = {}
}

variable "additionalLabels" {
  description = "Chart value `additionalLabels`. Chart default: {}"
  type        = any
  default     = {}
}

variable "enableCertManager" {
  description = "Chart value `enableCertManager`. Chart default: false"
  type        = any
  default     = null
}

variable "certManager" {
  description = "Chart value `certManager`. Chart default: {'duration': '8760h0m0s', 'renewBefore': '720h0m0s', 'revisionHistoryLimit': null, 'rootCert': {'duration': '43800h0m0s'}}"
  type        = any
  default     = {}
}

variable "clusterName" {
  description = "Chart value `clusterName`. Chart default: null"
  type        = any
  default     = null
}

variable "cluster" {
  description = "Chart value `cluster`. Chart default: {'dnsDomain': 'cluster.local'}"
  type        = any
  default     = {}
}

variable "ingressClass" {
  description = "Chart value `ingressClass`. Chart default: 'alb'"
  type        = any
  default     = null
}

variable "ingressClassParams" {
  description = "Chart value `ingressClassParams`. Chart default: {'create': true, 'name': null, 'spec': {}}"
  type        = any
  default     = {}
}

variable "createIngressClassResource" {
  description = "Chart value `createIngressClassResource`. Chart default: true"
  type        = any
  default     = null
}

variable "region" {
  description = "Chart value `region`. Chart default: null"
  type        = any
  default     = null
}

variable "vpcId" {
  description = "Chart value `vpcId`. Chart default: null"
  type        = any
  default     = null
}

variable "vpcTags" {
  description = "Chart value `vpcTags`. Chart default: {}"
  type        = any
  default     = {}
}

variable "awsApiEndpoints" {
  description = "Chart value `awsApiEndpoints`. Chart default: null"
  type        = any
  default     = null
}

variable "awsApiThrottle" {
  description = "Chart value `awsApiThrottle`. Chart default: null"
  type        = any
  default     = null
}

variable "awsMaxRetries" {
  description = "Chart value `awsMaxRetries`. Chart default: null"
  type        = any
  default     = null
}

variable "defaultTargetType" {
  description = "Chart value `defaultTargetType`. Chart default: 'instance'"
  type        = any
  default     = null
}

variable "defaultLoadBalancerScheme" {
  description = "Chart value `defaultLoadBalancerScheme`. Chart default: null"
  type        = any
  default     = null
}

variable "enablePodReadinessGateInject" {
  description = "Chart value `enablePodReadinessGateInject`. Chart default: null"
  type        = any
  default     = null
}

variable "enableShield" {
  description = "Chart value `enableShield`. Chart default: null"
  type        = any
  default     = null
}

variable "enableWaf" {
  description = "Chart value `enableWaf`. Chart default: null"
  type        = any
  default     = null
}

variable "enableWafv2" {
  description = "Chart value `enableWafv2`. Chart default: null"
  type        = any
  default     = null
}

variable "ingressMaxConcurrentReconciles" {
  description = "Chart value `ingressMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "logLevel" {
  description = "Chart value `logLevel`. Chart default: null"
  type        = any
  default     = null
}

variable "metricsBindAddr" {
  description = "Chart value `metricsBindAddr`. Chart default: ''"
  type        = any
  default     = null
}

variable "webhookConfig" {
  description = "Chart value `webhookConfig`. Chart default: {'disableIngressValidation': null, 'ingressValdationFailurePolicy': 'Fail', 'ingressValidationObjectSelector': {'matchExpressions': null, 'matchLabels': null..."
  type        = any
  default     = {}
}

variable "webhookBindPort" {
  description = "Chart value `webhookBindPort`. Chart default: null"
  type        = any
  default     = null
}

variable "webhookTLS" {
  description = "Chart value `webhookTLS`. Chart default: {'caCert': null, 'cert': null, 'key': null}"
  type        = any
  default     = {}
}

variable "keepTLSSecret" {
  description = "Chart value `keepTLSSecret`. Chart default: false"
  type        = any
  default     = null
}

variable "webhookNamespaceSelectors" {
  description = "Chart value `webhookNamespaceSelectors`. Chart default: null"
  type        = any
  default     = null
}

variable "serviceMaxConcurrentReconciles" {
  description = "Chart value `serviceMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "targetgroupbindingMaxConcurrentReconciles" {
  description = "Chart value `targetgroupbindingMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "targetgroupbindingMaxExponentialBackoffDelay" {
  description = "Chart value `targetgroupbindingMaxExponentialBackoffDelay`. Chart default: null"
  type        = any
  default     = null
}

variable "targetgroupbindingRequeueDuration" {
  description = "Chart value `targetgroupbindingRequeueDuration`. Chart default: null"
  type        = any
  default     = null
}

variable "albGatewayMaxConcurrentReconciles" {
  description = "Chart value `albGatewayMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "nlbGatewayMaxConcurrentReconciles" {
  description = "Chart value `nlbGatewayMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "globalAcceleratorMaxConcurrentReconciles" {
  description = "Chart value `globalAcceleratorMaxConcurrentReconciles`. Chart default: null"
  type        = any
  default     = null
}

variable "globalAcceleratorMaxExponentialBackoffDelay" {
  description = "Chart value `globalAcceleratorMaxExponentialBackoffDelay`. Chart default: null"
  type        = any
  default     = null
}

variable "lbStabilizationMonitorInterval" {
  description = "Chart value `lbStabilizationMonitorInterval`. Chart default: null"
  type        = any
  default     = null
}

variable "syncPeriod" {
  description = "Chart value `syncPeriod`. Chart default: null"
  type        = any
  default     = null
}

variable "watchNamespace" {
  description = "Chart value `watchNamespace`. Chart default: null"
  type        = any
  default     = null
}

variable "disableIngressClassAnnotation" {
  description = "Chart value `disableIngressClassAnnotation`. Chart default: null"
  type        = any
  default     = null
}

variable "disableIngressGroupNameAnnotation" {
  description = "Chart value `disableIngressGroupNameAnnotation`. Chart default: null"
  type        = any
  default     = null
}

variable "tolerateNonExistentBackendService" {
  description = "Chart value `tolerateNonExistentBackendService`. Chart default: null"
  type        = any
  default     = null
}

variable "tolerateNonExistentBackendAction" {
  description = "Chart value `tolerateNonExistentBackendAction`. Chart default: null"
  type        = any
  default     = null
}

variable "defaultSSLPolicy" {
  description = "Chart value `defaultSSLPolicy`. Chart default: null"
  type        = any
  default     = null
}

variable "livenessProbe" {
  description = "Chart value `livenessProbe`. Chart default: {'failureThreshold': 2, 'httpGet': {'path': '/healthz', 'port': 61779, 'scheme': 'HTTP'}, 'initialDelaySeconds': 30, 'timeoutSeconds': 10}"
  type        = any
  default     = {}
}

variable "readinessProbe" {
  description = "Chart value `readinessProbe`. Chart default: {'failureThreshold': 2, 'httpGet': {'path': '/readyz', 'port': 61779, 'scheme': 'HTTP'}, 'successThreshold': 1, 'initialDelaySeconds': 10, 'timeoutSeconds': 10}"
  type        = any
  default     = {}
}

variable "env" {
  description = "Chart value `env`. Chart default: null"
  type        = any
  default     = null
}

variable "hostNetwork" {
  description = "Chart value `hostNetwork`. Chart default: false"
  type        = any
  default     = null
}

variable "dnsPolicy" {
  description = "Chart value `dnsPolicy`. Chart default: null"
  type        = any
  default     = null
}

variable "extraVolumeMounts" {
  description = "Chart value `extraVolumeMounts`. Chart default: null"
  type        = any
  default     = null
}

variable "extraVolumes" {
  description = "Chart value `extraVolumes`. Chart default: null"
  type        = any
  default     = null
}

variable "defaultTags" {
  description = "Chart value `defaultTags`. Chart default: {}"
  type        = any
  default     = {}
}

variable "podDisruptionBudget" {
  description = "Chart value `podDisruptionBudget`. Chart default: {}"
  type        = any
  default     = {}
}

variable "externalManagedTags" {
  description = "Chart value `externalManagedTags`. Chart default: []"
  type        = any
  default     = null
}

variable "enableEndpointSlices" {
  description = "Chart value `enableEndpointSlices`. Chart default: null"
  type        = any
  default     = null
}

variable "enableBackendSecurityGroup" {
  description = "Chart value `enableBackendSecurityGroup`. Chart default: null"
  type        = any
  default     = null
}

variable "enableManageBackendSecurityGroupRules" {
  description = "Chart value `enableManageBackendSecurityGroupRules`. Chart default: null"
  type        = any
  default     = null
}

variable "backendSecurityGroup" {
  description = "Chart value `backendSecurityGroup`. Chart default: null"
  type        = any
  default     = null
}

variable "disableRestrictedSecurityGroupRules" {
  description = "Chart value `disableRestrictedSecurityGroupRules`. Chart default: null"
  type        = any
  default     = null
}

variable "maxTargetsPerTargetGroup" {
  description = "Chart value `maxTargetsPerTargetGroup`. Chart default: null"
  type        = any
  default     = null
}

variable "controllerConfig" {
  description = "Chart value `controllerConfig`. Chart default: {'featureGates': {}}"
  type        = any
  default     = {}
}

variable "certManagement" {
  description = "Chart value `certManagement`. Chart default: {}"
  type        = any
  default     = {}
}

variable "certDiscovery" {
  description = "Chart value `certDiscovery`. Chart default: {'allowedCertificateAuthorityARNs': ''}"
  type        = any
  default     = {}
}

variable "objectSelector" {
  description = "Chart value `objectSelector`. Chart default: {'matchExpressions': null, 'matchLabels': null}"
  type        = any
  default     = {}
}

variable "serviceMonitor" {
  description = "Chart value `serviceMonitor`. Chart default: {'enabled': false, 'namespace': null, 'additionalLabels': {}, 'interval': '1m', 'scrapeTimeout': null, 'relabelings': null, 'metricRelabelings': null}"
  type        = any
  default     = {}
}

variable "clusterSecretsPermissions" {
  description = "Chart value `clusterSecretsPermissions`. Chart default: {'allowAllSecrets': false}"
  type        = any
  default     = {}
}

variable "ingressClassConfig" {
  description = "Chart value `ingressClassConfig`. Chart default: {'default': false}"
  type        = any
  default     = {}
}

variable "enableServiceMutatorWebhook" {
  description = "Chart value `enableServiceMutatorWebhook`. Chart default: true"
  type        = any
  default     = null
}

variable "serviceMutatorWebhookConfig" {
  description = "Chart value `serviceMutatorWebhookConfig`. Chart default: {'failurePolicy': 'Fail', 'objectSelector': {'matchExpressions': [], 'matchLabels': {}}, 'namespaceSelectors': null, 'operations': ['CREATE']}"
  type        = any
  default     = {}
}

variable "podMutatorWebhookConfig" {
  description = "Chart value `podMutatorWebhookConfig`. Chart default: {'failurePolicy': 'Ignore'}"
  type        = any
  default     = {}
}

variable "serviceTargetENISGTags" {
  description = "Chart value `serviceTargetENISGTags`. Chart default: null"
  type        = any
  default     = null
}

variable "loadBalancerClass" {
  description = "Chart value `loadBalancerClass`. Chart default: null"
  type        = any
  default     = null
}


output "release_name" {
  value = helm_release.this.name
}
output "namespace" {
  value = helm_release.this.namespace
}
output "status" {
  value = helm_release.this.status
}
output "chart_version" {
  value = helm_release.this.version
}
