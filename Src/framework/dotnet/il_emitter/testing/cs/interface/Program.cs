﻿using System;

// Define an interface
interface IPrintable
{
    void Print();
}
interface IMark
{

}

public class Program : IPrintable, IMark
{
    // A private field name
    private string name;

    // A public property Name with get and set accessors
    public string Name
    {
        get { return name; }
        set { name = value; }
    }

    // Implement the Print method from the IPrintable interface
    public void Print()
    {
        Console.WriteLine(Name);
    }

    public static void Main()
    {
        Program program = new Program();

        // Set the Name property
        program.Name = "John Doe with IMark";

        // Call the Print method to output the Name property to the console
        program.Print();
    }
}
