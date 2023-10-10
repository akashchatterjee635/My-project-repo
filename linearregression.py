import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

# Load the dataset
data = pd.read_csv("linear_regression_data.csv")

# Extract X and Y data
X = data['X'].values.reshape(-1, 1)
Y = data['Y'].values

# Create and fit the linear regression model
model = LinearRegression()
model.fit(X, Y)

# Make predictions
Y_pred = model.predict(X)

# Plot the data points and regression line
plt.scatter(X, Y, label='Data Points')
plt.plot(X, Y_pred, color='red', label='Regression Line')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Linear Regression')
plt.legend()
plt.show()

# Display the regression coefficients
slope = model.coef_[0]
intercept = model.intercept_
print(f"Slope (m): {slope:.2f}")
print(f"Intercept (b): {intercept:.2f}")
