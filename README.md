<div id="top"></div>

<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

</div>

<br />
<div align="center">
  <a href="https://github.com/philips-labs/continuous-compliance-action">
    <img src="https://github.com/philips-labs/continuous-compliance-action/blob/579f7a89bbc213ef1f07e010e5fb79d171cda95a/.github/branding/cc-7.png" alt="Logo" width="140" height="140">
  </a>

  <h3 align="center">Continuous Compliance GitHub Action</h3>

  <p align="center">
    Github Action automatically enforce company policy on repositories using Repolinter.
    <br>
    <a href="https://github.com/philips-labs/continuous-compliance-action/issues">Report Bug</a>
    ·
    <a href="https://github.com/philips-labs/continuous-compliance-action/issues">Request Feature</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## Description

Continuous Compliance makes it possible to enforce company policy on repositories. Continuous Compliance will automatically check your repository for mandatory files or requirements. When possible, it will create detailed Github issue with instructions on how to resolve it.

## State

Work in progress - We're testing this action internally at this moment...  
If you want to stay updated, hit the "Watch" button.

## Background

Philips was looking for a way to automatically enforce certain policy in their innersource [philips-internal](https://github.com/philips-internal) organization.
After stumbling upon Repolinter and Newrelics Action, we decided we wanted something slightly different and more versatile. We started working on a fork of Repolinter, one that introduced the ability create different GitHub issues per rule that was broken. After having this specific functionality added, we needed a way to automatically check the 5000+ repositories within our internal organization. This is when Continuous Compliance was born. We have used it for several months internally, and learned a lot by doing so. By publishing the source code, we want to share it with a broader community. We have migrated our internal Continuous Compliance, to use this open source one(have to eat your own dog food!).

### Built With

- [Repolinter](https://github.com/philips-labs/repolinter) (forked, [original here](https://github.com/todogroup/repolinter))

<p align="right">(<a href="#top">back to top</a>)</p>

## Usage

The easiest way to use this action is to add the following into your workflow file. Additional configuration might be necessary to fit your usecase.
Add the following part in your workflow file:
See [Continuous-Compliance-Template](https://github.com/philips-labs/continuous-compliance-template) for a full example on how to feed repos into Continuous Compliance and how to use Git as a local database.

  ```yaml
  continuous-compliance:
    name: continuous-compliance
    runs-on: ubuntu-20.04

    steps:
      - name: Create ruleset config
        id: config
        run: |
          echo "::set-output name=ENCODED_RULESET::$(cat ./config/repolint.json | base64 -w 0)"

      - name: Perform repolinter on repositories
        uses: philips-labs/continuous-compliance-action@v0.1.1
        with:
          ruleset: ${{steps.config.outputs.ENCODED_RULESET}} 
          gh_token: ${{steps.token.outputs.token}}
          target_repos: my-org/repo1,my-org/repo2
  ```

### Inputs

| parameter | description | required | default |
| - | - | - | - |
| ruleset | Base64 encoded ruleset config file or url to ruleset config file. | `true` | |
| gh_token | Github token that has permissions to create labels, issues and has read rights to view files. | `true` | |
| target_repos | Target Repositories (my-org/repository,my-org/repository-2) | `true` | |

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

Get started quickly by reading the information below.

### Prerequisites

Ensure you have the following installed:

- Bash
- Docker

#### Recommendations

The following IDE is recommended when working on this codebase:

- [VSCode](https://code.visualstudio.com/)

### Local Installation

1. Clone the repo.

   ```sh
   git clone git@github.com:philips-labs/continuous-compliance-action.git
   ```

1. Build the docker image

   ```sh
   docker build .
   ```

1. Run the docker locally build docker image.

   ```sh
   docker run IMAGE_ID_HERE
   ```

### Docker Image

Our Docker image is available at GitHub Container Registry (ghcr).

**GitHub Container Registry**
See all available images [here.](https://github.com/philips-labs/continuous-compliance-action/pkgs/container/continuous-compliance)
Run the Docker image by doing:

```sh
docker run ghcr.io/philips-labs/continuous-compliance:0.1
```

The Docker image includes the repolinter project, and the scripts required to make Continuous Compliance work.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

If you have a suggestion that would make this project better, please fork the repository and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please refer to the [Contributing Guidelines](/CONTRIBUTING.md) for all the guidelines.

<p align="right">(<a href="#top">back to top</a>)</p>

## License

Distributed under the MIT License. See [LICENSE](/LICENSE.md) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contact

- [Brend Smits](https://github.com/Brend-Smits)
- [Jeroen Knoops](https://github.com/JeroenKnoops)

<p align="right">(<a href="#top">back to top</a>)</p>

## Acknowledgments

This project is inspired by:

- [TODO Group Repolinter](https://github.com/todogroup/repolinter)
- [Newrelic Repolinter Action](https://github.com/newrelic/repolinter-action)

<p align="right">(<a href="#top">back to top</a>)</p>

[contributors-shield]: https://img.shields.io/github/contributors/philips-labs/continuous-compliance-action.svg?style=for-the-badge
[contributors-url]: https://github.com/philips-labs/continuous-compliance-action/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/philips-labs/continuous-compliance-action.svg?style=for-the-badge
[forks-url]: https://github.com/philips-labs/continuous-compliance-action/network/members
[stars-shield]: https://img.shields.io/github/stars/philips-labs/continuous-compliance-action.svg?style=for-the-badge
[stars-url]: https://github.com/philips-labs/continuous-compliance-action/stargazers
[issues-shield]: https://img.shields.io/github/issues/philips-labs/continuous-compliance-action.svg?style=for-the-badge
[issues-url]: https://github.com/philips-labs/continuous-compliance-action/issues
[license-shield]: https://img.shields.io/github/license/philips-labs/continuous-compliance-action.svg?style=for-the-badge
[license-url]: https://github.com/philips-labs/continuous-compliance-action/blob/main/LICENSE.md
