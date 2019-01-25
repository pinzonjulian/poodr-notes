# Practical Object Oriented Design in Ruby
Personal Notes on Sandy Metz's Practical Object Oriented Design in Ruby

# Chapter 1: Object-Oriented Design

> Application that are easy to change are apleasure to write and a joy to extend . They're flexible and adaptable. Applications tha tresist change are just the opposite; every change is expensive and each makes the next cost more.

###### The object and the message

Object oriented design is made up of two main concepts: the parts and the interaction between the parts. These are called the **Objects** and the **Messages**

The thing with interaction is that it requires the sender and reciever to know things about each other. This knowledge creates dependency between the objects which **is not desired**. The objective is to *arrange dependencies such that objects can tolerate change*. 

###### A practical definition of design

> You must not only write code for the feature you plan to deliver today, you must also create code that is amenable to being changed later.

> you must combine an overall understanding of your application's requirements with knowledge of the costs and benefits of design alternatives and then devise an arrangement of code that is **cost effective in te present and will continue to be so in the future**

> The purpose of design is to allow you to do design later and its primary goal is to reduce the cost of change.

###### Judging design

> If design takes half your time htis month and does nt start returning dividents for ayear, it may not be wirth it. When the acto of design prevents software from being delivered on time, you have lost. Delivering half of a well-designed application might be the same as delivering no application at all. Hoever, if design takes half of your time this morning, payos that itme back this afternoon, and then continues to provide benefits for the lifetime of the applicaiton, you get a kind of daily compounding interest on your time; this design effor pays forever.

# Chapter 2: Designing classes with a Single Responsibility

> Your goal is to model your application, using classes, such that it does what it is supposed to do right now and is also easy to change later.

> Design is more the art of preserving changeability than it is the act of achieving perfeciton.

###### Organizing code to allow for easy changes

What does "easy changes" mean?
- A change you make should have no unexpected side effects. It should be obvious and apparent what it does and the effect it has in your application
- Small changes in requirements require correspondingly small changes in code
- Easy to use. Easy to expand.

To achieve this, your code should be T.R.U.E:

1. Transparent: I immediatelly think of callbacks in Rails applications. They are so automagical that you don't know what's happening under the hood. They're useful but should be used with caution and maybe they shouldn't handle critical behaviour. _The consequences of change should be obvious in the code that is changing **and in distant code** relies upon it.

2. Reasonable: _The cost of any change should be proportional to the benefits the change achieves_
3. Usable: The code you already wrote should be usable in new and unexpected contexts.
4. Exemplary: Developers copy the practices and methodologies other developers already coded. Be mindful of this as you and other developers will reuse the same practices.


