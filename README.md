# GrandCentralDispatch
GCD in iOS


- Created a thread safe array using Dispatch Semaphore
- Demonstrated the use of Dispatch Queues, Dispatch work item, Dispatch Group


https://user-images.githubusercontent.com/88600263/137418442-a4d5bf14-1fb0-4e69-810f-2ceecf89d785.mov


The crash happens because two threads are trying to access the same resource at the same time. Using Thread safe array implemnted with Dispatch semaphore solves this problem.



![Screen Shot 2021-10-14 at 9 40 57 PM](https://user-images.githubusercontent.com/88600263/137418799-42517a14-a83e-45ab-846c-21f17f661b5b.png)
