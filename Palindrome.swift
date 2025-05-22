import Foundation
//
//  Palindrome.swift
//
//  Created by Val I on 2025-04-06.
//  Version 1.0
//  Copyright (c) 2025 Val I. All rights reserved.
//
// The Palindrome program checks if a number is a palindrome.
//Either given a number or reading from file
//

// Function to check if a number is a palindrome
func palindrome(_ number: Int) -> Bool {
    let numberStr = String(number)
    if numberStr.count <= 1 {
        return true
    } else {
        let firstChar = numberStr.first!
        let lastChar = numberStr.last!
        // Check if the first and last characters are equal
        if firstChar != lastChar {
            return false
        } else {
            // Remove first and last characters and check the rest recursively
            let middlePart = numberStr.dropFirst().dropLast()
            return palindrome(Int(middlePart)!)
        }
    }
}
// Prompt the user for input
print("Do you want to get the info from")
print("A file(F)")
print("Your input(I)")
print("Please select F or I: ")

// Read user input
if let input = readLine()?.lowercased() {
    // Determine the file based on user input
    var fileName: String
    if input == "f" {
        fileName = "./input.txt"
        // makes file path
        guard let input = FileHandle(forReadingAtPath: fileName) else {
            print("Error: can't find input file")
            exit(1)
        }
        // Open the output file for writing
        guard let output = FileHandle(forWritingAtPath: "./output.txt") else {
            print("Error: can't open output file")
            exit(1)
        }
        // Read the contents of the input file
        let inputData = input.readDataToEndOfFile()

        // Convert the data to a string
        guard let inputStr = String(data: inputData, encoding: .utf8) else {
            print("Error: can't convert input data to string")
            exit(1)
        }
    
        // Split the string into lines
        let lines = inputStr.components(separatedBy: .newlines)

    // initialize the message
    var message = ""

        // Process each line
        for line in lines {
            if let inputInt = Int(line) {
                // Calls palindrome function and checks if result is true
                if palindrome(inputInt) {
                    message = "\(inputInt) is a palindrome"
                } else {
                    message = "\(inputInt) is not a palindrome"
                }
            } else {
                message = "\(line) is not an integer."
            }
            // Write the output to the output file
            output.write(message.data(using: .utf8)!)
            output.write("\n".data(using: .utf8)!)
        }
    } else if input == "i" {
        // prompt user input
        print("Please enter a number:")
        // Read user input
        if let input = readLine(){
            // Check if the input is an integer
            if let inputInt = Int(input){
                // Calls palindrome function and checks if result is true
                if palindrome(inputInt) {
                    print("\(inputInt) is a palindrome")
                } else {
                    print("\(inputInt) is not a palindrome")
                }
            } else {
            print("Invalid input. Please enter an integer.")
        } 
        }
    } else {
        print("Invalid option. Please select F or I.")
        exit(0)
    }

}