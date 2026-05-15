![BRAPH 2](braph2banner.png)

[![BRAPH 2](https://img.shields.io/badge/Bluesky-BRAPH%202-blue?style=social&logo=bluesky&url=https%3A%2F%2Fbraph2software.bsky.social)](https://braph2software.bsky.social)
[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![BRAPH 2 preprint](https://img.shields.io/badge/bioRxiv-BRAPH%202-blue)](https://doi.org/10.1101/2025.04.11.648455)

# GapVAE

**GapVAE** is a BRAPH 2 distribution for unsupervised representation learning, clustering, data generation, and missing-data completion using variational autoencoders.

The name **GapVAE** combines two ideas:

- **GapNet**, a deep-learning framework designed to analyse incomplete multimodal biological data, from the following publication:

> Chang et al., *Neural network training with highly incomplete medical datasets*.
> [Machine Learning: Science and Technology 3, 035001](https://iopscience.iop.org/article/10.1088/2632-2153/ac7b69).  

- **Variational Autoencoder (VAE)**, a generative neural-network model that learns a latent representation of data and can generate or reconstruct samples.

GapVAE is designed for applications in **neuroimaging**, **proteomics**, **genomics**, and other biomedical datasets where missingness, multimodal structure, and latent biological variation are central analytical challenges.

The distribution provides example pipelines for:

- unsupervised clustering in latent space
- data generation from learned latent representations
- data reconstruction and completion
- proof-of-concept validation using the MNIST handwritten-digit dataset
- future extension to multimodal biomedical data

GapVAE reuses the core infrastructure of **BRAPH 2**, including its object-oriented data structure, graphical user interface, neural-network elements, and Genesis-based software-generating mechanism.

For a general introduction to BRAPH 2, please refer to the main [BRAPH 2 repository](https://github.com/braph-software/BRAPH-2/tree/develop).

---

## Example figures

<img width="1486" height="896" alt="fig1" src="https://github.com/user-attachments/assets/98802043-ce5e-43ff-a99b-09be810d35ce" />

> 
> **Latent-space clustering of MNIST digits**
> Each point represents one image, and colours indicate digit labels. Although labels are shown for visualisation, the VAE learns the latent representation in an unsupervised manner. This example validates the basic use of Gap VAE for latent-space exploration and unsupervised clustering.
> 

<img width="1486" height="896" alt="fig2" src="https://github.com/user-attachments/assets/de8c812a-bfee-47b5-937d-22a30e84176e" />

> 
> **Generated handwritten digits sampled from the learned VAE latent space**
> The smooth transition between digit-like images illustrates that the model has learned a continuous and meaningful latent representation. This provides a proof of concept for data generation and reconstruction, which can later be extended to biomedical data completion.
> 
