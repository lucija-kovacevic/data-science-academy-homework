<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main">
    <img src=https://karijere.fer.hr/wp-content/uploads/2023/01/hr-Academy-1920x1080-just-logo.png alt="Logo" width="300" height="200">
  </a>

<h3 align="center">Sofascore meets Docker</h3>

  <p align="center">
    <br />
    <a href="https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main"><strong>Explore the docs »</strong></a>
    <br />
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>

  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
This project is made as an example of attempt to dockerize python code which downloads, extracts, cleans data and creates usable table on remote server. Main goal was to prepare app for developement and production environment.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Docker](https://img.shields.io/badge/docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
* [![ClickHouse](https://img.shields.io/badge/ClickHouse-FF6C37?style=for-the-badge&logo=clickhouse&logoColor=white)](https://clickhouse.tech/)
* [![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
* [<img src="https://jobfair.fer.unizg.hr/api/i/clemrmu7o0011qp34c96q9f6j/full" alt="Sofascore" width="100" height="20"/>](https://www.sofascore.com/)





<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you can start application using Docker.
To get a local copy up and running follow these simple example steps.

### Prerequisites

* Docker Desktop

Docker Desktop is a one-click-install application for your Mac, Linux, or Windows environment that lets you build, share, and run containerized applications and microservices.

1. Go to official Docker site [Docker Desktop](https://www.docker.com/get-started/)
2. Download version for either Mac, Linux, or Windows from dropdown menu at 
   ```sh
   Download button
   ```

### Installation in development environment

1. Download [HM4](https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main/HM4) directory from github and place it to desired place on your host.
2. Open CMD (or any other command-line interpreter for your os).
3. Place it into _HM4_ folder:
   3.1 Windows
   ```sh
   cd host\path\to\HM4
   ```
   3.2 macOS or Linux
    ```sh
   cd host/path/to/HM4
   ```
3. Build and run containers:
```sh
docker-compose up
```

### Installation in production environment
Once images are deloyed to docker hub (or some other repo, see [my Docker hub](https://hub.docker.com/u/luckovac)) we can acces them without downloading everything to host.

1. Copy docker-compose.yml file onto your host. Make sure to add appropriate password and username.
  ```sh
version: '3'
services:
    extraction:
      image: "luckovac/extraction:latest"
      volumes:
        - shared_data:/app/raw_data
      environment:
        USERNAME: username
        PASSWORD: password

    processing:
      image: "luckovac/processing:latest"
      depends_on: 
        extraction:
          condition: service_completed_successfully
      volumes:
        - shared_data:/app/output

    inserting:
      image: "luckovac/inserting:latest"
      depends_on: 
        processing:
          condition: service_completed_successfully
      volumes:
        - shared_data:/app
      environment:
        USERNAME: username
        PASSWORD: password

volumes:
    shared_data:

  ```
2. Build and run containers:
```sh
cd /path/to/docker-compose.yml
docker-compose up
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

This app uses 3 different containers to provide service with 3 images. First image is used for getting zip and tar files from remote host and then extracting its contents for further processing. Second is used for cleaning data and mergeing it into one managable file prepared for database. Third image inserts cleaned data to remote server where it can be used by other developers and further analysed.

This can be done in one .py file, one image and one container since we are working with sample sized code, but having in mind possible expansion of services provided by this app, these are 3 most diferentiated wholes that can be upgraded more easly, if separated.


_For more examples, please refer to the [Documentation](https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main/HM4)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Using .env files to list files for dowloading
- [ ] Implementig healthcheck
- [ ] Runing Clickhouse in Docker


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Lucija Kovačević - lucija.kovacevic123@gmail.com

Project Link: [https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main/HM4](https://github.com/lucija-kovacevic/data-science-academy-homework/tree/main/HM4)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/lucija-kova%C4%8Devi%C4%87-178988223/

[product-screenshot]: images/screenshot.png




