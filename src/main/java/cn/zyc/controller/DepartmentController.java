package cn.zyc.controller;

import cn.zyc.pojo.Department;
import cn.zyc.pojo.Msg;
import cn.zyc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author zyc
 * @date 2021/6/9
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts(); //
        return Msg.success().add("depts",list);
    }

}
