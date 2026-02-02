# Cow wisdom web server
Deployment: [wisecow.isujith.dev](https://wisecow.isujith.dev) <br>
K8s Manifests Repo: [/kubecorner/wisecow](https://github.com/SujithThirumalaisamy/kubecorner/tree/main/wisecow) <br>
Tfm Infra  Repo: [/homelab/terraform](https://github.com/SujithThirumalaisamy/homelab/blob/main/terraform/cloudflare/dns.tf) (Cloudfalre DNS with Terraform)

> Manifests are maintained in `sujiththirumalaisamy/kubecorner` as its my manifest project which I have use for my ArgoCD Deployments. I already have this same setup in my portfolio repo `sujiththirumalaisamy/cv.me` <br>
> Also the dns `wisecow.isujith.dev` is managed in `sujiththirumalaisamy/homelab/terraform/cloudflare/dns.tf` with terraform cloud state for the dns resource via terraform infra provisioning
## Prerequisites

```
sudo apt install fortune-mod fortunes cowsay -y
```

## How to use?

1. Run `./wisecow.sh`
2. Point the browser to server port (default 4499)

## What to expect?
![wisecow](https://github.com/nyrahul/wisecow/assets/9133227/8d6bfde3-4a5a-480e-8d55-3fef60300d98)

# Problem Statement
Deploy the wisecow application as a k8s app

## Requirement
[x] Create Dockerfile for the image and corresponding k8s manifest to deploy in k8s env. The wisecow service should be exposed as k8s service.
[x] Github action for creating new image when changes are made to this repo
[x] [Challenge goal]: Enable secure TLS communication for the wisecow app.

## Expected Artifacts
[x] Github repo containing the app with corresponding dockerfile, k8s manifest, any other artifacts needed.
[x] Github repo with corresponding github action.
[x] Github repo should be kept private and the access should be enabled for following github IDs: nyrahul
