import nltk
nltk.download('vader_lexicon')
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# Create a SentimentIntensityAnalyzer object
sid = SentimentIntensityAnalyzer()

# Define some sample text
text = "I love this product! It's amazing."

# Perform sentiment analysis
sentiment_scores = sid.polarity_scores(text)

# Interpret the sentiment scores
if sentiment_scores['compound'] >= 0.05:
    sentiment = "Positive"
elif sentiment_scores['compound'] <= -0.05:
    sentiment = "Negative"
else:
    sentiment = "Neutral"

# Display the results
print(f"Sentiment: {sentiment}")
print(f"Positive: {sentiment_scores['pos']:.2f}")
print(f"Negative: {sentiment_scores['neg']:.2f}")
print(f"Neutral: {sentiment_scores['neu']:.2f}")
