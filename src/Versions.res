type version = {"name": string, "french-law": string, "catala-web-assets": string}

@module("../../assets-versions.json") external available: array<version> = "available"
