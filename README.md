# Getting-and-Cleaning-data

First step is to download the files. Then there is a training set and a test set which
need to be read. The folder structure is the same so we can write one function for
the train and test set. Which is called Read_data and returns a dataset. First the
Y_data is read, which is the activity preformed. Then the subject ID is read which is 
the tested subject. The columnnames of the X data can be found in features.txt. Then these 
colnames are combined with the X data.
 
Then the columns that describe a mean or std diviation are inculded. Next to this are
the subject ID's and X end data combined. Next step is to read in the Activity Names and
merge these with the Y_data, such that we get the translation for the activities. 
The output is combined with data created before.

This is done for both train and test and then the both are row bind. Then the colnames
are changed for readable names. t/f stand for time or frequence.

The output of this function can be used in the mean_dataset function, were the dataset
is groupby Activity and subject. Then the mean is calculated over the grouped columns.