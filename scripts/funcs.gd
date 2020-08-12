extends Node


# Calculates the dot product of two matrixes, or an array and a matrix
func dotProduct(matrix1, matrix2):
	var mat1Cols
	var mat2Rows
	var mat2Cols
	var prodMat = []
	var mat1Array = false
	var mat2Col = []
	var prodArray = []
	
	# Checking number of columns in matrix1
	if typeof(matrix1[0]) != TYPE_ARRAY: #Checking if array position 0 is something other than an array, indicating 1 dimentional array
		mat1Cols = len(matrix1)
		mat1Array = true
	else:	# More than 1 array, so getting length of array at pos 0
		mat1Cols = len(matrix1[0])
	
	mat2Rows = len(matrix2)
	mat2Cols = len(matrix2[0])
	
	# Checking for valid matrix shapes
	if mat1Cols != mat2Rows:
		push_error("Shape error, matrix1 has" + str(mat1Cols) + " columns, but matrix2 has " + str(mat2Rows) + " rows.")
		get_tree().quit()
	
	# If matrix1 is actually a 1 dimension array, calculate dot product
	if mat1Array:
		for x in range(0, mat1Cols):
			for y in range(0, mat2Rows):
				mat2Col.append(matrix2[x][y])
			prodArray.append(multArray(matrix1,mat2Col))
			mat2Col = []
		return prodArray
	
	else:
		# Calculating dot product of matrices
		for line in matrix1:
			for x in range(0, mat2Cols):
				for y in range(0, mat2Rows):
					mat2Col.append(matrix2[y][x])
				prodArray.append(multArray(line,mat2Col))
				mat2Col = []
			prodMat.append(prodArray)
			prodArray = []
		return prodMat


# Function for multiplying two arrrays
func multArray(array1,array2):
	var array1Len = len(array1)
	var array2Len = len(array2)
	
	# Checking that arrays are of equal length
	if array1Len != array2Len:
		push_error("Arrays need to be the same length")
		get_tree().quit()
	
	# Multiplying arrays
	var total = 0
	for x in range(0,array1Len):
		total += array1[x] * array2[x]
	
	return total


# Generate a matrix of a given size, populated with random values between a given range
func randMatrix(rows, columns, minVal = 0.0, maxVal = 100.00):
	var matrix = []
	var tempArray = []
	for x in range(0, rows):
		for y in range(0, columns):
			tempArray.append(rand_range(minVal, maxVal))
		matrix.append(tempArray)
		tempArray = []
	
	return matrix


# Add a scalar value to a matrix or array
func addScalar(matrix, scalar):
	var isArray = false
	var numCols = len(matrix[0])
	var newMatrix = []
	
	# Check if 1 dimensional array
	if typeof(matrix[0]) != TYPE_ARRAY:
		isArray = true
	
	if isArray:
		for x in range(0, len(matrix)):
			newMatrix.append(matrix[x] + scalar)
		return newMatrix
	else:
		for x in range(0, len(matrix)):
			for y in range(0, numCols):
				newMatrix.append(matrix[x][y] + scalar)
		return newMatrix


# Create matrix of given size full of zeroes
func newZeroMatrix(rows, columns):
	var newMatrix = []
	var tempArray = []
	var isArray = false
	
	if rows == 1:
		isArray = true
	
	if isArray:
		for x in range(0, columns):
			newMatrix.append(0)
		return newMatrix
	else:
		for x in range(0, rows):
			for y in range(0, columns):
				tempArray.append(0)
			newMatrix.append(tempArray)
			tempArray = []
		return newMatrix


# Format matrix for printing
func matrix2Str(matrix):
	var rows = len(matrix)
	var matrixStr = ""
	
	for x in range(0, rows):
		matrixStr += str(matrix[x]) + "\n"
	
	return matrixStr
