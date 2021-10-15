# GrandCentralDispatch
GCD in iOS


- Created a thread safe array using Dispatch Semaphore
- Demonstrated the use of Dispatch Queues, Dispatch work item, Dispatch Group


![Simulator Screen Shot - iPhone 13 mini - 2021-10-14 at 20 37 14](https://user-images.githubusercontent.com/88600263/137418427-b751c1dd-313a-445c-a168-9cf46e163956.png)




https://user-images.githubusercontent.com/88600263/137418442-a4d5bf14-1fb0-4e69-810f-2ceecf89d785.mov


The crash happens because two threads are trying to access the same resource at the same time. Using Thread safe array implemnted with Dispatch semaphore solves this problem.
