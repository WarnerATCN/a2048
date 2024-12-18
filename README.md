跟着B站前辈学习2048小游戏，并结合自己的开发经验进行优化的代码。
非常适合Swift及SwiftUI初始者学习。

原始地址：
https://www.bilibili.com/video/BV1TV411z7QM?spm_id_from=333.788.videopod.episodes&vd_source=5bb3af02842b527b34177870c7580573&p=4

1、取消了Card类， 并将业务合并进了SingleCard中
2、取消了索引查找，直接使用SingleCard对象定位
3、增加了分数和高分榜
4、对合并逻辑进行了优化
5、增加了合并过程的动画，使之更平滑
6、增加本地高分榜存储和加载
