package cn.zyc.test;

import cn.zyc.mapper.DepartmentMapper;
import cn.zyc.mapper.EmployeeMapper;
import cn.zyc.pojo.Department;
import cn.zyc.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author zyc
 * @date 2021/6/8
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //1.插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //2.插入员工
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=1;i<1000;i++){
            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@zyc.com",1));
        }

    }

}
