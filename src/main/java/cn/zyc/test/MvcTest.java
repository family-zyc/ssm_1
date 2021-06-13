package cn.zyc.test;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author zyc
 * @date 2021/6/8
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc-config.xml"})
public class MvcTest {

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;
    //spring-mvc的ioc容器
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求 获取返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pn", "1")).andReturn();
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页数" + pageInfo.getPages());
        System.out.println("总记录数" + pageInfo.getTotal());
        System.out.println("----获取员工数据-----");
        List list = pageInfo.getList();
        list.forEach(System.out::println);
    }


}
