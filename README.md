# WAI-SmartWaste
An image classification model that will determine the most environmentally friendly method of disposal for a piece of waste (i.e. aluminum can → recyclable, food waste → compost, etc...)

# Instructions
To use the WAI-SmartWaste app follow these instuctions bellow:
1. go to https://i.diawi.com/stpejy and install the app called "frontend" (this app only works with ios devices)
2. open the camera app on your phone and take a photo of a piece of trash (cardboard, glass, metal, paper, plastic, trash)
3. ensure the photo features the respect object with a single color background
4. open the `frontend` app
5. select the photo you took in step 2
6. hit `detect trash`
7. wait (this may take longer then excpected) - you should see an activity indicator to validate your request was sent successfully
8. a popup should appear with the results of your analyzed photo

# Frontend
Frontend of our project was created on xcode using swiftui

# Backend
Backend of our project was created with flask and deployed to google cloud
