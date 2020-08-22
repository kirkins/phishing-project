## Introduction

Phishing is the art of impersonating another website in order to gain confidential information like a user password, or personal data like social security number [1]. Phishing attacks have grown to be a major problem in modern computer security. Phishing attacks are damaging to individuals who may lose account access or have accounts unknowingly opened in their names, it is also damaging to the brands and companies who are imitated by phishing websites [2].

While several solutions have been proposed such as blacklists there are several limitations that arise out of the fact that new phishing attacks and websites are constantly being created. Another unique solution involves the use of machine learning using neural networks to detect phishing links. In this paper we’ll look at 3 studies which use different approaches for detecting phishing links with neural networks. We’ll also recreate these experiments in an associated Juypter Notebook and record our results.

## Datasets

Using machine learning to detect phishing links can either involve analyzing the links themselves, or involve both analyzing the link and the website which the link leads to. One of the most crucial components of this strategy is the feature engineering which takes place before running a dataset through a machine learning algorithm. This involves looking at sets of website links and extracting features which may be useful for detecting if said link is malicious in nature.

Often these features are split into broader categories. For example “address bar based features”, “abnormal based features”, “HTML and JavaScript based features”, and “domain based features”. These are the broad categories used in the dataset produced by R. M. Mohammad [4]. Examples of the features in these categories include things like the number of dots in the domain. Less than 3 dots being normal, 3 dots being slightly suspicious, and more than 3 being a clear sign of a potential phishing link [2].

Additional features emphasized in another paper by R. M. Mohammad [1] also included groups of features based on “security and encryption”, “page style and contents”, and “social human factor”. Page contents and human factors are particularly interesting, though one downside in the mining process would be that it requires the sites to be visited and the content of those sites analyzed in depth, thus using a greater amount of computing power.

For example one feature listed in “page style and contents” is spelling errors, meaning this single feature requires a full parsing and spell check of all page contents. Compared to the feature of how many dots appear in a url this is rather intensive. Though from a security point of view spelling errors can certainly be indicative of a phishing website. Features listed in the “social human factor” category may be even more intensive for example “much emphasis on security and response” would require the full page text be analyzed and potential meaning of the text extracted, though simple keyword extraction may be sufficient.

Another dataset prepared by Vrbančič contains 111 different extracted features for each link [5]. Many of these features listed can be extracted through methods like regex in a pre-processing phase for example “does url contain an email”, “number of hyphens”, ect. Despite the list containing many more features than those listed by R. M. Mohammad [1] they may nonetheless be easier to extract due to being based on the URL itself rather than page content. This factor has specifically been pointed out by Bahnsen et al. who attempts to only consider factors which can be extracted from the URL itself in order to significantly lower the evaluation time [3].

The dataset which should be a mix of both phishing and non-phishing links is then used as the input for a neural network in an attempt to predict the outcome of if a link is phishing or not based on the extracted features. 

In contrast to the approaches of Vrbančič and R. M. Mohammad the paper by Bahnsen et al. [3] did not make use of any type of feature extraction. That includes features which require crawling and page and even simpler features which are extracted by hard-set rules like that described regarding amounts of dots in a url. Instead Bahnsen et al. make use of only the raw url with a neural network using LSTM.

The dataset used by Bahnsen et al. [3] with LSTM is significantly larger in terms of rows than the others, it includes 1 million phishing links from Phishtank and 1 million harmless links from CommonCrawl, for a total for 2 millions rows. This is significantly larger than the 11,055 rows used by R. M. Mohammad and the 88,647 rows used by Vrbančič. We wanted to obtain or simulate the dataset from Bahnsen et al. [3] but were only successful in gathering 95,910 rows of similar data.

## Neural Networks

Neural networks are well suited to take advantage of these mined datasets due to a variety of attributes including nonlinearity, adaptiveness, generalization, fault-tolerance, and identical design steps [1]. Neural networks can be built using a consistent set of steps. This is a strong contributing factor to why a process for automating their creation was suggested by Mohammad [1].

Beyond using a neural network additional decisions must be made about the parameters and algorithms used at each layer. Bahnsen et al. make use of an LSTM layer followed by a Sigmoid function [3]. Whereas Vrbančič et al. compare several different algorithms in their neural network including linear regression, bat algorithm (based on the movements of groups of bats in nature), hybrid-bat algorithm, and firefly algorithm (based on the flashing behaviour of fireflies) [1].

Other variables include the amount of hidden layers and the number of neurons used at each layer. The amount of neurons used requires some experimentation either through a constructive approach starting with a small number and slowly incrementing, or through a purning approach starting with a high estimate and slowly removing neurons [1]. Experimenting with the ideal amount of neurons can be computationally intensive as processing datasets with large layers can be extremely slow.

## Experiment

In our experiment we used the constructive method to experiment the neuron amounts for the datasets provided by both R. M. Mohammad [4] and Vrbančič [5]. For the dataset provided by R. M. Mohammad we found a starting ratio with a good result and continued to double the neuron count until results stopped improving. Initially results improved with each doubling this improved was small. Eventually the resulting accuracy peaked at which point each successive doubling had worse results. By the end computation time for each had grown significantly. 

Another difference between our experiment and that done by R. M. Mohammad et al. is that we found our best result to make use of 2 layers rather than 1. While most single layer configurations had better results we found one configuration making use of 2 hidden rectified linear unit layers one with 400 neurons in the first layer and 480 neurons in the second gave us our most accurate on average configuration.

To find this we tested 26 different neuron amounts ranging from 20 to 11,500 for a neural network with a single hidden layer. For 2 layer networks we tested 16 different configurations, the lowest being 30/40 and the highest being 12,800/15,360. From these results we took the best performing single layered configuration 2300 neurons and the best performing 2 layered network 400/480 and ran them 10 times each to get an average. The average of the 2 layered network was 96.69% as compared to the average of 96.652% with the 1 layered network. We also ran the second best single layered network 5 additional times but discontinued testing it when the average didn’t appear promising as a possible best single layer configuration.

As our best 2 layered network configuration was only better by 0.038% it is hard to conclude that is definitely better, but it seems at worst our best 2 layered configuration is equal to the best single layered configuration. 

A similar attempt was made with the dataset from Vrbančič [5]. As this dataset had significantly more attribute columns the minimum layer was always higher than that of the previous dataset, 111 as compared to 30. Though even with 111 neurons the ratio was 1 to 1 compared to the 3 to 1 with the previous dataset. 

However this same model did not translate to the second dataset [5] in which we experimented with several different layer amounts. From 2 layers up to 8 layers we found that adding additional layers improved our results until we had 6 layers at which point we weren’t able to further improve results by adding layers. Having so many layers on the dataset with 111 columns made it much more difficult to test as each round of testing took longer, and the increased amount of layers led to more possible neuron count combinations between these layers.

The best results we were able to find with the second dataset was 7 layers of which 6 were 160 neurons, and the last being a sigmoid output layer.

## Parameters

In [2] [7] there is discussion about modifying the default learning rate in order to improve the results of a neural network and other algorithms. We have taken our best results from the first round of testing and re-ran with a variety of learning rates based on the ideal one suggested by Vrbančič et al.

For dataset #1 found that the best performance was achieved with a learning rate of 0.002, however these results weren’t an improvement over the default results achieved without setting the learning rate.

## References

*[1] Mohammad, R.M., Thabtah, F. & McCluskey, L. Predicting phishing websites based on self-structuring neural network. Neural Comput & Applic 25, 443–458 (2014). https://doi.org/10.1007/s00521-013-1490-z*

*[2] Vrbančič, Grega & Fister jr, Iztok & Podgorelec, Vili. (2019). Parameter Setting for Deep Neural Networks Using Swarm Intelligence on Phishing Websites Classification. International Journal on Artificial Intelligence Tools. 28. 1960008. 10.1142/S021821301960008X.*

*[3] Bahnsen, Alejandro Correa, et al. "Classifying phishing URLs using recurrent neural networks." 2017 APWG symposium on electronic crime research (eCrime). IEEE, 2017.*

*[4] R. M. Mohammad, F. Thabtah and L. McCluskey, An assessment of features related to phishing websites using an automated technique, in Internet Technology And Secured Transactions, 2012 International Conference for IEEE2012, pp. 492–497.*

*[5] G. Vrbančič, Phishing dataset (2019), Available at https://github.com/GregaVrbancic/Phishing-Dataset, Accessed: 2020-02-29.*

*[6] Benavides, Eduardo & Fuertes, Walter & Sanchez-Gordon, Sandra & Sanchez, Manuel. (2020). Classification of Phishing Attack Solutions by Employing Deep Learning Techniques: A Systematic Literature Review. 10.1007/978-981-13-9155-2_5.*

*[7] Vrbančič, Grega & Fister jr, Iztok & Podgorelec, Vili. (2018). Swarm Intelligence Approaches for Parameter Setting of Deep Learning Neural Network: Case Study on Phishing Websites Classification. 1-8. 10.1145/3227609.3227655.*
