package com.movie.web.api;

import com.movie.core.dto.CategoryDTO;
import com.movie.core.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController(value = "CategoryAPIOfAdmin")
public class CategoryAPI {
    @Autowired
    private ICategoryService categoryService;

    @PostMapping("/api/admin/category")
    public CategoryDTO saveCategory(@RequestBody CategoryDTO categoryDTO) {
        try {
            categoryDTO = categoryService.save(categoryDTO);
        } catch (IOException ex) {
            return null;
        }
        return categoryDTO;
    }

    @PutMapping("/api/admin/category")
    public CategoryDTO updateCategory(@RequestBody CategoryDTO categoryDTO) {
        try {
            categoryDTO = categoryService.save(categoryDTO);
        } catch (IOException ex) {
            return null;
        }
        return categoryDTO;
    }

    @DeleteMapping("/api/admin/category")
    public void deleteCategory(@RequestBody Long[] ids) {
        categoryService.delete(ids);
    }
}
