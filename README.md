# Kneaddata-BMtagger Docker Images

This is a Docker image for Kneaddata & BMtagger tools. This project is
to create a container for Kneaddata and BMtagger and no functionality
has been added or removed from original tools during containerization.

## Build instructions ##

Docker image is created via `Dockerfile` that performs all the necessary
operations and uses `kneaddata_bmtagger_env.yml` file to add kneaddata
and bmtagger tools in conda environment.

```
% cat kneaddata_bmtagger_env.yml

name: runtime
channels:
  - bioconda
  - conda-forge
dependencies:
  - kneaddata=0.12.0=pyhdfd78af_1
  - bmtagger==3.101
```

GitHub actions are used to build the container image on tag change
and push it to GitHub container registry.

## Release instructions

When tagging a new version please use annotated tags in the command line
interface.

```bash
git clone --branch master git@github.com:wtsi-npg/kneaddata_bmtagger.git kneaddata_bmtagger && cd $_
git tag -a 'x.y.z' -m 'release x.y.z'
git push origin x.y.z
```

Releases are created and published automatically by a GitHub Action on tag
creation. Using the web interface to create a release will cause that
automation to fail.

## Acknowledgments

Github actions for publishing container image is based on
[BAMBI](https://github.com/wtsi-npg/bambi/blob/devel/.github/workflows/create-release.yml).

## Author

Avnish Pratap Singh as74@sanger.ac.uk