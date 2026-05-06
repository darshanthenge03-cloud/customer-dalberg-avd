## 🏗 Enterprise Architecture

### High-Level Architecture

```text
┌──────────────────────────────────────────────────┐
│               Azure Subscription                 │
└──────────────────────────────────────────────────┘
                           │
            ┌──────────────┴──────────────┐
            │                             │
            ▼                             ▼

┌─────────────────────────┐   ┌─────────────────────────┐
│      Networking RG      │   │         AVD RG          │
├─────────────────────────┤   ├─────────────────────────┤
│ • Virtual Network       │   │ • Host Pool             │
│ • AVD Subnet            │   │ • Workspace             │
│ • ADDS Subnet           │   │ • Desktop App Group     │
│ • Bastion Subnet        │   │ • Session Hosts         │
│ • GatewaySubnet         │   │                         │
└─────────────────────────┘   └─────────────────────────┘

                           │
                           ▼

┌──────────────────────────────────────────────────┐
│               Terraform Backend                  │
├──────────────────────────────────────────────────┤
│ • Azure Storage Account                          │
│ • Remote Terraform State                         │
└──────────────────────────────────────────────────┘
```

<div align="center">

### ⚡ Enterprise-Ready Infrastructure Platform

Reusable • Scalable • Automated • Secure

</div>
