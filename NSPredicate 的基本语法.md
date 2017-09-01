###  NSPredicate 的基本语法

#### 比较运算符

1. =、==：判断两个表达式是否相等，在谓词中=和==是相同的意思都是判断，而没有赋值这一说

   ```objective-c
   NSNumber *testNumber = @123;
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = 123"];
   if ([predicate evaluateWithObject:testNumber]) 
   {
     NSLog(@"testString:%@", testNumber);
   }
   ```

2. \>=，=>：判断左边表达式的值是否大于或等于右边表达式的值

3. <=，=<：判断右边表达式的值是否小于或等于右边表达式的值

4. \>：判断左边表达式的值是否大于右边表达式的值

5. <：判断左边表达式的值是否小于右边表达式的值

6. !=、<>：判断两个表达式是否不相等

7. BETWEEN：BETWEEN表达式必须满足表达式 BETWEEN {下限，上限}的格式，要求该表达式必须大于或等于下限，并小于或等于上限, Demo如下

   ```objective-c
   NSNumber *testNumber = @123;
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {100, 200}"];
     if ([predicate evaluateWithObject:testNumber]) {
         NSLog(@"testString:%@", testNumber);
     } else {
         NSLog(@"不符合条件");
     }
   ```

#### 逻辑运算符

1. AND、&&：逻辑与，要求两个表达式的值都为YES时，结果才为YES

   ```objective-c
   NSArray *testArray = @[@1, @2, @3, @4, @5, @6];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF > 2 && SELF < 5"];
     NSArray *filterArray = [testArray filteredArrayUsingPredicate:predicate];
     NSLog(@"filterArray:%@", filterArray);
   ```

2. OR、||：逻辑或，要求其中一个表达式为YES时，结果就是YES

3. NOT、 !：逻辑非，对原有的表达式取反

#### 字符串比较运算符

1. BEGINSWITH：检查某个字符串是否以指定的字符串开头（如判断字符串是否以a开头：BEGINSWITH 'a'）
2. ENDSWITH：检查某个字符串是否以指定的字符串结尾
3. CONTAINS：检查某个字符串是否包含指定的字符串
4. LIKE：检查某个字符串是否匹配指定的字符串模板。其之后可以跟?代表一个字符和*代表任意多个字符两个通配符。比如"name LIKE '*ac*'"，这表示name的值中包含ac则返回YES；"name LIKE '?ac*'"，表示name的第2、3个字符为ac时返回YES。
5. MATCHES：检查某个字符串是否匹配指定的正则表达式。虽然正则表达式的执行效率是最低的，但其功能是最强大的，也是我们最常用的。

> 特别说明: 字符串比较都是区分大小写和重音符号的。如：café和cafe是不一样的，Cafe和cafe也是不一样的。如果希望字符串比较运算不区分大小写和重音符号，请在这些运算符后使用[c]，[d]选项。其中[c]是不区分大小写，[d]是不区分重音符号，其写在字符串比较运算符之后，比如：name LIKE[cd] 'cafe'，那么不论name是cafe、Cafe还是café上面的表达式都会返回YES。

#### 集合运算符

1. ANY、SOME：集合中任意一个元素满足条件，就返回YES。

2. ALL：集合中所有元素都满足条件，才返回YES。

3. NONE：集合中没有任何元素满足条件就返回YES。如:NONE person.age < 18，表示person集合中所有元素的age>=18时，才返回YES。

4. IN：等价于SQL语句中的IN运算符，只有当左边表达式或值出现在右边的集合中才会返回YES。我们通过一个例子来看一下

   ```objective-c
   NSArray *filterArray = @[@"ab", @"abc"];
     NSArray *array = @[@"a", @"ab", @"abc", @"abcd"];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filterArray];
     NSLog(@"%@", [array filteredArrayUsingPredicate:predicate])
   ```

5. array[index]：返回array数组中index索引处的元素

6. array[FIRST]：返回array数组中第一个元素

7. array[LAST]：返回array数组中最后一个元素

8. array[SIZE]：返回array数组中元素的个数

#### 直接量

1. FALSE、NO：代表逻辑假
2. TRUE、YES：代表逻辑真
3. NULL、NIL：代表空值
4. SELF：代表正在被判断的对象自身
5. "string"或'string'：代表字符串
6. 数组：和c中的写法相同，如：{'one', 'two', 'three'}。
7. 数值：包括证书、小数和科学计数法表示的形式
8. 十六进制数：0x开头的数字
9. 八进制：0o开头的数字
10. 二进制：0b开头的数字

#### 保留字(不区分大小写)

```objective-c
AND、OR、IN、NOT、ALL、ANY、SOME、NONE、LIKE、CASEINSENSITIVE、CI、MATCHES、CONTAINS、BEGINSWITH、ENDSWITH、BETWEEN、NULL、NIL、SELF、TRUE、YES、FALSE、NO、FIRST、LAST、SIZE、ANYKEY、SUBQUERY、CAST、TRUEPREDICATE、FALSEPREDICATE
```

### NSPredicate 的用法

#### 用法一

```objc
ZLPersonModel *sunnyzl = [ZLPersonModel personWithName:@"sunnyzl" age:29 sex:ZLPersonSexMale];
    ZLPersonModel *jack = [ZLPersonModel personWithName:@"jack" age:22 sex:ZLPersonSexMale];
    //  首先我们来看一些简单的使用
    //  1.判断姓名是否是以s开头的
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"name LIKE 's*'"];
    //  输出为：sunnyzl:1, jack:0
    NSLog(@"sunnyzl:%d, jack:%d", [pred1 evaluateWithObject:sunnyzl], [pred1 evaluateWithObject:jack]);
    //  2.判断年龄是否大于25
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"age > 25"];
    //  输出为：sunnyzl的年龄是否大于25：1, jack的年龄是否大于25：0
    NSLog(@"sunnyzl的年龄是否大于25：%d, jack的年龄是否大于25：%d", [pred2 evaluateWithObject:sunnyzl], [pred2 evaluateWithObject:jack]);
```

#### 用法二:判断手机号是否正确

```objc
 - (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}
```

#### 用法三: 谓词匹配正则的缺点

```objc
- (BOOL)checkSpecialCharacter:(NSString *)string
{
    NSString *regex = @"[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}
```

​	这总与我们的想法事与愿违，看到这里我们会发现谓词对正则并不像我们使用NSRegularExpression时匹配的那么好，究其原因是为什么呢？我们用NSRegularExpression时会发现匹配到一个结果时就会存入数组，再从匹配到的位置继续向下匹配。

然而NSPredicate并不会做这样的自动操作，我们最终发现在NSPredicate输入[`~!@#$^&*()=|{}':;',\[\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]正则表达式时和写成^[`~!@#$^&*()=|{}':;',\[\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]$的效果是一样的。

所以通过这个例子我们总结出来，只有在正则表达式为^表达式$时才使用谓词，而不是所有情况都使用。

那么我们是不是因为这一点就摒弃它了呢，答案是否定的。因为虽然NSPredicate有这么一点瑕疵，但是它总体带给我们的便利其实除了正则表达式匹配时的这个问题外是更多的。

### 使用谓词过滤集合

1. NSArray提供了如下方法使用谓词来过滤集合

   ```objc
   // 使用指定的谓词过滤NSArray集合，返回符合条件的元素组成的新集合
   - (NSArray*)filteredArrayUsingPredicate:(NSPredicate *)predicate;
   ```

2. NSMutableArray提供了如下方法使用谓词来过滤集合

   ```objc
   // 使用指定的谓词过滤NSMutableArray，剔除集合中不符合条件的元素
   - (void)filterUsingPredicate:(NSPredicate *)predicate：
   ```

3. NSSet提供了如下方法使用谓词来过滤集合

   ```objc
   // 作用同NSArray中的方法
   - (NSSet*)filteredSetUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：
   ```

4. NSMutableSet提供了如下方法使用谓词来过滤集合

   ```objc
   // 作用同NSMutableArray中的方法。
   - (void)filterUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：
   ```

#### 相关示例

```objc
NSMutableArray *arrayM = [@[@20, @40, @50, @30, @60, @70] mutableCopy];
    //  过滤大于50的值
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF > 50"];
    [arrayM filterUsingPredicate:pred1];
    NSLog(@"arrayM:%@", arrayM);
    NSArray *array = @[[ZLPersonModel personWithName:@"Jack" age:20 sex:ZLPersonSexMale],
                       [ZLPersonModel personWithName:@"Rose" age:22 sex:ZLPersonSexFamale],
                       [ZLPersonModel personWithName:@"Jackson" age:30 sex:ZLPersonSexMale],
                       [ZLPersonModel personWithName:@"Johnson" age:35 sex:ZLPersonSexMale]];
    //  要求取出包含‘son’的元素
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"name CONTAINS 'son'"];
    NSArray *newArray = [array filteredArrayUsingPredicate:pred2];
    NSLog(@"%@", newArray);
```



```objc
NSArray *filterArray = @[@"ab", @"abc"];
    NSArray *array = @[@"a", @"ab", @"abc", @"abcd"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filterArray];
    NSLog(@"%@", [array filteredArrayUsingPredicate:predicate]);
```



#### 在谓词中使用占位符参数

* %K：用于动态传入属性名

* %@：用于动态设置属性值

* 还可以在谓词表达式中使用动态改变的属性值，就像环境变量一样

  ```objc
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS $VALUE"];
  ```

  > 上述表达式中，$VALUE是一个可以动态变化的值，它其实最后是在字典中的一个key，所以可以根据你的需要写不同的值，但是必须有$开头，随着程序改变$VALUE这个谓词表达式的比较条件就可以动态改变。

```objc
NSArray *array = @[[ZLPersonModel personWithName:@"Jack" age:20 sex:ZLPersonSexMale],
                     [ZLPersonModel personWithName:@"Rose" age:22 sex:ZLPersonSexFamale],
                     [ZLPersonModel personWithName:@"Jackson" age:30 sex:ZLPersonSexMale],
                     [ZLPersonModel personWithName:@"Johnson" age:35 sex:ZLPersonSexMale]];
  //  定义一个property来存放属性名，定义一个value来存放值
  NSString *property = @"name";
  NSString *value = @"Jack";
  //  该谓词的作用是如果元素中property属性含有值value时就取出放入新的数组内，这里是name包含Jack
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", property, value];
  NSArray *newArray = [array filteredArrayUsingPredicate:pred];
  NSLog(@"newArray:%@", newArray);
   
  //  创建谓词，属性名改为age，要求这个age包含$VALUE字符串
  NSPredicate *predTemp = [NSPredicate predicateWithFormat:@"%K > $VALUE", @"age"];
  // 指定$SUBSTR的值为 25    这里注释中的$SUBSTR改为$VALUE
  NSPredicate *pred1 = [predTemp predicateWithSubstitutionVariables:@{@"VALUE" : @25}];
  NSArray *newArray1 = [array filteredArrayUsingPredicate:pred1];
  NSLog(@"newArray1:%@", newArray1);
   
  //  修改 $SUBSTR的值为32，  这里注释中的SUBSTR改为$VALUE
  NSPredicate *pred2 = [predTemp predicateWithSubstitutionVariables:@{@"VALUE" : @32}];
  NSArray *newArray2 = [array filteredArrayUsingPredicate:pred2];
  NSLog(@"newArray2:%@", newArray2);
```



