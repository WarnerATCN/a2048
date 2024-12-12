跟着B站前辈学习2048小游戏，并结合自己的开发经验进行优化的代码： https://www.bilibili.com/video/BV1TV411z7QM?spm_id_from=333.788.videopod.episodes&vd_source=5bb3af02842b527b34177870c7580573&p=4

1、取消了Card类， 并将业务合并进了SingleCard中
2、取消了索引查找，直接使用SingleCard对象定位
