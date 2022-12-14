package com.ablaze.controller;

import com.ablaze.entity.*;
import com.ablaze.service.AbsentService;
import com.ablaze.service.BuildingService;
import com.ablaze.service.DormitoryService;
import com.ablaze.service.StudentService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author: ablaze
 * @Date: 2022/09/26/9:54
 */
@Controller
@RequestMapping("/absent")
public class AbsentController {

    @Autowired
    private AbsentService absentService;

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private DormitoryService dormitoryService;

    @Autowired
    private StudentService studentService;

    @GetMapping("/listPage")
    public ModelAndView list(@RequestParam(defaultValue = "1") int page,@RequestParam(defaultValue = "5") int size) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("absentrecord");
        PageInfo pageInfos = new PageInfo(absentService.list(page,size));
        modelAndView.addObject("pageInfos",pageInfos);
        return modelAndView;
    }

    @PostMapping("/search")
    public ModelAndView search(String key ,String value, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int size) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("absentrecord");
        PageInfo pageInfos = new PageInfo(absentService.search(key, value, page, size));
        modelAndView.addObject("pageInfos", pageInfos);
        return modelAndView;
    }

    @GetMapping("/init")
    public ModelAndView init(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int size) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("absentregister");
        List<Building> buildingList = buildingService.list(page,size);
        modelAndView.addObject("buildingList",buildingList);
        List<Dormitory> dormitoryList = dormitoryService.findByBuildingId(buildingList.get(0).getId());
        modelAndView.addObject("dormitoryList",dormitoryList);
        List<Student> studentList = studentService.findByDormitoryId(dormitoryList.get(0).getId());
        modelAndView.addObject("studentList",studentList);
        return modelAndView;
    }

    @PostMapping("/save")
    public String save(Absent absent, HttpSession session) {
        DormitoryAdmin dormitoryAdmin = (DormitoryAdmin)session.getAttribute("dormitoryAdmin");
        absent.setDormitoryAdminId(dormitoryAdmin.getId());
        absentService.save(absent);
        return "redirect:/absent/init";
    }
}
